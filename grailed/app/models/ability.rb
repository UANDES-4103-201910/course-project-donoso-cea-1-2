
class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    can :manage, :all if user.role == "admin"
    can :manage, User, id: user.id
    can :read, :all
    can :manage, Post, user_id: user.id || user.role == "admin"
    can :manage, Comment, user_id: user.id || user.role == "admin"
  end
  
end


