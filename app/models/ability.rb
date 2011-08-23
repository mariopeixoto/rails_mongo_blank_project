class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user
    
    if user.role? :ADMIN
      can :manage, :all
      
      can [:home], [User]
      can [:create, :destroy], [Authentication]
    elsif user.role? :USER
      can :read, :all
      
      can [:home], [User]
      can [:create, :destroy], [Authentication]
    else
      can [:create], [Authentication]
    end
    
  end
  
end
