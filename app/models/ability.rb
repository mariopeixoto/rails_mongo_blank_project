class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user
    
    if user.role? :ADMIN
      can :manage, :all
      
      can [:home, :preferences], [User]
    elsif user.role? :USER
      can :read, :all
      
      can [:home, :preferences], [User]
    else
      cannot :all
    end
  end
  
end
