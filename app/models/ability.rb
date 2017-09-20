class Ability
  include CanCan::Ability

  def initialize(user, session = nil)
    user ||= User.new # guest user (not logged in)
    if user && user.role == "admin"
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      can :manage, :all               # allow admins to do anything
    else
      can :read, :all                 # allow everyone to read everything
      can :update, Cart, id: session[:cart_id]
      can :manage, LineItem, cart: { id: session[:cart_id] }
      # cannot :read, Order, shipping_method: { id: 3 }
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
