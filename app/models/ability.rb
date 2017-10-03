class Ability
  include CanCan::Ability

  def initialize(user, session = nil)
    user ||= User.new
    if user && user.role == 'admin'
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    else
      can :read, :all
      return unless session
      can :update, Cart, id: session[:cart_id]
      can :manage, LineItem, cart: { id: session[:cart_id] }
      can :manage, Order, id: session[:order_id]
    end
  end
end
