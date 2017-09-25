class Ability
  include CanCan::Ability

  def initialize(user, session = nil)
    user ||= User.new
    if user && user.role == "admin"
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      can :manage, :all               # allow admins to do anything
    else
      can :read, :all                 # allow everyone to read everything
      return unless session
      can :update, Cart, id: session[:cart_id]
      can :manage, LineItem, cart: { id: session[:cart_id] }
      can :manage, Order, id: session[:order_id]
    end
  end
end
