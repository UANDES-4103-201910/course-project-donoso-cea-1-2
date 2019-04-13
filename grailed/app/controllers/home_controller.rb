class HomeController < ApplicationController
  def start
    render #"start"
    #render json: "{ \"status\" : \"success\" }"
  end
end
