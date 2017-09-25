class Orders::OrdersController < ApplicationController
  include CurrentCart
  include CurrentOrder
  before_action :authenticate_user!
  before_action :ensure_cart_isnt_empty, only: [:create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :sanitize_filter_param, only: [:index]

  authorize_resource

  def index
    @orders = current_user.orders.send(params[:state]).order('completed_at DESC')
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

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit()
    end

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
