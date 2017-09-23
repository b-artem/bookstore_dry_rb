class Orders::OrdersController < ApplicationController
  include CurrentCart
  include CurrentOrder
  before_action :set_cart, only: [:create]
  before_action :ensure_cart_isnt_empty, only: [:create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  authorize_resource
  # before_action :create_order_and, only: :show

  # GET /orders
  # GET /orders.json
  def index
    set_cart
    @orders = Order.all.order(:id)
  end

  # GET /orders/1
  # GET /orders/1.json
  # def show
  #
  # end

  # GET /orders/new
  # def new
  #   @order = Order.new
  # end

  # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.create(coupon: @cart.coupon)
    set_current_order(@order)
    add_line_items_to_order_from_cart(@cart)
    destroy_cart
    redirect_to order_checkouts_path(@order)

    # @order = Order.new(order_params)
    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
    #     format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
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

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit()
    end

    def add_line_items_to_order_from_cart(cart)
      cart.line_items.each do |item|
        item.update(cart_id: nil, order_id: @order.id)
        # line_items << item
      end
    end
end
