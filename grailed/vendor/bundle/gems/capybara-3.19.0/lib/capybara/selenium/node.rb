# frozen_string_literal: true

# Selenium specific implementation of the Capybara::Driver::Node API

require 'capybara/selenium/extensions/find'
require 'capybara/selenium/extensions/scroll'

class Capybara::Selenium::Node < Capybara::Driver::Node
  include Capybara::Selenium::Find
  include Capybara::Selenium::Scroll

  def visible_text
    native.text
  end

  def all_text
    text = driver.evaluate_script('arguments[0].textContent', self)
    text.gsub(/[\u200b\u200e\u200f]/, '')
        .gsub(/[\ \n\f\t\v\u2028\u2029]+/, ' ')
        .gsub(/\A[[:space:]&&[^\u00a0]]+/, '')
        .gsub(/[[:space:]&&[^\u00a0]]+\z/, '')
        .tr("\u00a0", ' ')
  end

  def [](name)
    native.attribute(name.to_s)
  rescue Selenium::WebDriver::Error::WebDriverError
    nil
  end

  def value
    if tag_name == 'select' && multiple?
      native.find_elements(:css, 'option:checked').map { |el| el[:value] || el.text }
    else
      native[:value]
    end
  end

  def style(styles)
    styles.each_with_object({}) do |style, result|
      result[style] = native.css_value(style)
    end
  end

  ##
  #
  # Set the value of the form element to the given value.
  #
  # @param [String] value    The new value
  # @param [Hash{}] options  Driver specific options for how to set the value
  # @option options [Symbol,Array] :clear (nil) The method used to clear the previous value <br/>
  #   nil => clear via javascript <br/>
  #   :none =>  append the new value to the existing value <br/>
  #   :backspace => send backspace keystrokes to clear the field <br/>
  #   Array => an array of keys to send before the value being set, e.g. [[:command, 'a'], :backspace]
  def set(value, **options)
    raise ArgumentError, "Value cannot be an Array when 'multiple' attribute is not present. Not a #{value.class}" if value.is_a?(Array) && !multiple?

    tag_name, type = attrs(:tagName, :type).map { |val| val&.downcase }
    @tag_name ||= tag_name

    case tag_name
    when 'input'
      case type
      when 'radio'
        click
      when 'checkbox'
        click if value ^ checked?
      when 'file'
        set_file(value)
      when 'date'
        set_date(value)
      when 'time'
        set_time(value)
      when 'datetime-local'
        set_datetime_local(value)
      else
        set_text(value, options)
      end
    when 'textarea'
      set_text(value, options)
    else
      set_content_editable(value)
    end
  end

  def select_option
    click unless selected? || disabled?
  end

  def unselect_option
    raise Capybara::UnselectNotAllowed, 'Cannot unselect option from single select box.' unless select_node.multiple?

    click if selected?
  end

  def click(keys = [], **options)
    click_options = ClickOptions.new(keys, options)
    return native.click if click_options.empty?

    click_with_options(click_options)
  rescue StandardError => e
    if e.is_a?(::Selenium::WebDriver::Error::ElementClickInterceptedError) ||
       e.message.match?(/Other element would receive the click/)
      scroll_to_center
    end

    raise e
  end

  def right_click(keys = [], **options)
    click_options = ClickOptions.new(keys, options)
    click_with_options(click_options) do |action|
      click_options.coords? ? action.context_click : action.context_click(native)
    end
  end

  def double_click(keys = [], **options)
    click_options = ClickOptions.new(keys, options)
    click_with_options(click_options) do |action|
      click_options.coords? ? action.double_click : action.double_click(native)
    end
  end

  def send_keys(*args)
    native.send_keys(*args)
  end

  def hover
    scroll_if_needed { browser_action.move_to(native).perform }
  end

  def drag_to(element)
    # Due to W3C spec compliance - The Actions API no longer scrolls to elements when necessary
    # which means Seleniums `drag_and_drop` is now broken - do it manually
    scroll_if_needed { browser_action.click_and_hold(native).perform }
    element.scroll_if_needed { browser_action.move_to(element.native).release.perform }
  end

  def tag_name
    @tag_name ||= native.tag_name.downcase
  end

  def visible?; boolean_attr(native.displayed?); end
  def readonly?; boolean_attr(self[:readonly]); end
  def multiple?; boolean_attr(self[:multiple]); end
  def selected?; boolean_attr(native.selected?); end
  alias :checked? :selected?

  def disabled?
    return true unless native.enabled?

    # WebDriver only defines `disabled?` for form controls but fieldset makes sense too
    find_xpath('self::fieldset/ancestor-or-self::fieldset[@disabled]').any?
  end

  def content_editable?
    native.attribute('isContentEditable')
  end

  def ==(other)
    native == other.native
  end

  def path
    driver.evaluate_script GET_XPATH_SCRIPT, self
  end

protected

  def scroll_if_needed
    yield
  rescue ::Selenium::WebDriver::Error::MoveTargetOutOfBoundsError
    scroll_to_center
    yield
  end

private

  def sibling_index(parent, node, selector)
    siblings = parent.find_xpath(selector)
    case siblings.size
    when 0
      '[ERROR]' # IE doesn't support full XPath (namespace-uri, etc)
    when 1
      '' # index not necessary when only one matching element
    else
      idx = siblings.index(node)
      # Element may not be found in the siblings if it has gone away
      idx.nil? ? '[ERROR]' : "[#{idx + 1}]"
    end
  end

  def boolean_attr(val)
    val && (val != 'false')
  end

  # a reference to the select node if this is an option node
  def select_node
    find_xpath(XPath.ancestor(:select)[1]).first
  end

  def set_text(value, clear: nil, **_unused)
    value = value.to_s
    if value.empty? && clear.nil?
      native.clear
    elsif clear == :backspace
      # Clear field by sending the correct number of backspace keys.
      backspaces = [:backspace] * self.value.to_s.length
      send_keys(*([:end] + backspaces + [value]))
    elsif clear.is_a? Array
      send_keys(*clear, value)
    else
      # Clear field by JavaScript assignment of the value property.
      # Script can change a readonly element which user input cannot, so
      # don't execute if readonly.
      driver.execute_script "if (!arguments[0].readOnly){ arguments[0].value = '' }", self unless clear == :none
      send_keys(value)
    end
  end

  def click_with_options(click_options)
    scroll_if_needed do
      action_with_modifiers(click_options) do |action|
        if block_given?
          yield action
        else
          click_options.coords? ? action.click : action.click(native)
        end
      end
    end
  end

  def scroll_to_center
    script = <<-'JS'
      try {
        arguments[0].scrollIntoView({behavior: 'instant', block: 'center', inline: 'center'});
      } catch(e) {
        arguments[0].scrollIntoView(true);
      }
    JS
    begin
      driver.execute_script(script, self)
    rescue StandardError # rubocop:disable Lint/HandleExceptions
      # Swallow error if scrollIntoView with options isn't supported
    end
  end

  def set_date(value) # rubocop:disable Naming/AccessorMethodName
    value = SettableValue.new(value)
    return set_text(value) unless value.dateable?

    # TODO: this would be better if locale can be detected and correct keystrokes sent
    update_value_js(value.to_date_str)
  end

  def set_time(value) # rubocop:disable Naming/AccessorMethodName
    value = SettableValue.new(value)
    return set_text(value) unless value.timeable?

    # TODO: this would be better if locale can be detected and correct keystrokes sent
    update_value_js(value.to_time_str)
  end

  def set_datetime_local(value) # rubocop:disable Naming/AccessorMethodName
    value = SettableValue.new(value)
    return set_text(value) unless value.timeable?

    # TODO: this would be better if locale can be detected and correct keystrokes sent
    update_value_js(value.to_datetime_str)
  end

  def update_value_js(value)
    driver.execute_script(<<-JS, self, value)
      if (arguments[0].readOnly) { return };
      if (document.activeElement !== arguments[0]){
        arguments[0].focus();
      }
      if (arguments[0].value != arguments[1]) {
        arguments[0].value = arguments[1]
        arguments[0].dispatchEvent(new InputEvent('input'));
        arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
      }
    JS
  end

  def set_file(value) # rubocop:disable Naming/AccessorMethodName
    path_names = value.to_s.empty? ? [] : value
    native.send_keys(Array(path_names).join("\n"))
  end

  def set_content_editable(value) # rubocop:disable Naming/AccessorMethodName
    # Ensure we are focused on the element
    click

    editable = driver.execute_script <<-JS, self
      if (arguments[0].isContentEditable) {
        var range = document.createRange();
        var sel = window.getSelection();
        arguments[0].focus();
        range.selectNodeContents(arguments[0]);
        sel.removeAllRanges();
        sel.addRange(range);
        return true;
      }
      return false;
    JS

    # The action api has a speed problem but both chrome and firefox 58 raise errors
    # if we use the faster direct send_keys.  For now just send_keys to the element
    # we've already focused.
    # native.send_keys(value.to_s)
    browser_action.send_keys(value.to_s).perform if editable
  end

  def action_with_modifiers(click_options)
    actions = browser_action.move_to(native, *click_options.coords)
    modifiers_down(actions, click_options.keys)
    yield actions
    modifiers_up(actions, click_options.keys)
    actions.perform
  ensure
    act = browser_action
    act.release_actions if act.respond_to?(:release_actions)
  end

  def modifiers_down(actions, keys)
    each_key(keys) { |key| actions.key_down(key) }
  end

  def modifiers_up(actions, keys)
    each_key(keys) { |key| actions.key_up(key) }
  end

  def browser
    driver.browser
  end

  def browser_action
    browser.action
  end

  def each_key(keys)
    keys.each do |key|
      key = case key
      when :ctrl then :control
      when :command, :cmd then :meta
      else
        key
      end
      yield key
    end
  end

  def find_context
    native
  end

  def build_node(native_node, initial_cache = {})
    self.class.new(driver, native_node, initial_cache)
  end

  def attrs(*attr_names)
    return attr_names.map { |name| self[name.to_s] } if ENV['CAPYBARA_THOROUGH']

    driver.evaluate_script <<~'JS', self, attr_names.map(&:to_s)
      (function(el, names){
        return names.map(function(name){
          return el[name]
        });
      })(arguments[0], arguments[1]);
    JS
  end

  GET_XPATH_SCRIPT = <<~'JS'
    (function(el, xml){
      var xpath = '';
    	var pos, tempitem2;

      while(el !== xml.documentElement) {
        pos = 0;
        tempitem2 = el;
        while(tempitem2) {
          if (tempitem2.nodeType === 1 && tempitem2.nodeName === el.nodeName) { // If it is ELEMENT_NODE of the same name
            pos += 1;
          }
          tempitem2 = tempitem2.previousSibling;
        }

        if (el.namespaceURI != xml.documentElement.namespaceURI) {
          xpath = "*[local-name()='"+el.nodeName+"' and namespace-uri()='"+(el.namespaceURI===null?'':el.namespaceURI)+"']["+pos+']'+'/'+xpath;
        } else {
          xpath = el.nodeName.toUpperCase()+"["+pos+"]/"+xpath;
        }

        el = el.parentNode;
      }
      xpath = '/'+xml.documentElement.nodeName.toUpperCase()+'/'+xpath;
      xpath = xpath.replace(/\/$/, '');
      return xpath;
    })(arguments[0], document)
  JS

  # SettableValue encapsulates time/date field formatting
  class SettableValue
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def to_s
      value.to_s
    end

    def dateable?
      !value.is_a?(String) && value.respond_to?(:to_date)
    end

    def to_date_str
      value.to_date.iso8601
    end

    def timeable?
      !value.is_a?(String) && value.respond_to?(:to_time)
    end

    def to_time_str
      value.to_time.strftime('%H:%M')
    end

    def to_datetime_str
      value.to_time.strftime('%Y-%m-%dT%H:%M')
    end
  end
  private_constant :SettableValue

  # ClickOptions encapsulates click option logic
  class ClickOptions
    attr_reader :keys, :options

    def initialize(keys, options)
      @keys = keys
      @options = options
    end

    def coords?
      options[:x] && options[:y]
    end

    def coords
      [options[:x], options[:y]]
    end

    def empty?
      keys.empty? && !coords?
    end
  end
  private_constant :ClickOptions
end