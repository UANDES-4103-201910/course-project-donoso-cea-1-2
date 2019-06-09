
class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    can :manage, User, id: user.id
    can :manage, Post, user_id: user.id
  end
  
end


