class Orders::OrdersController < ApplicationController
  include CurrentOrder
  before_action :authenticate_user!
  before_action :ensure_cart_isnt_empty, only: [:create]
  before_action :sanitize_filter_param, only: [:index]
  load_and_authorize_resource through: :current_user, except: :create
  authorize_resource only: :create

  def index
    @orders = @orders.public_send(params[:state]).order('completed_at DESC')
  end

  def show
  end

  def create
    @order = current_user.orders.create(coupon: @cart.coupon)
    set_current_order(@order)
    add_line_items_to_order_from_cart(@cart)
    destroy_cart
    redirect_to order_checkouts_path(@order)
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

    def sanitize_filter_param
      params[:state] ||= 'in_queue'
      unless Order.aasm.states.map(&:name).include?(params[:state].to_sym)
        params[:state] = 'in_queue'
      end
    end

    def add_line_items_to_order_from_cart(cart)
      cart.line_items.each do |item|
        item.update(cart_id: nil, order_id: @order.id)
      end
    end
end
