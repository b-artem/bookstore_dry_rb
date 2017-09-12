class Orders::CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CurrentOrder
  require 'pry'
  # include Rectify::ControllerHelpers
  # before_action :set_form, only: [:show]
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @current_order = current_order
    case step
    when :address
      @order = Forms::OrderForm.from_model(current_order)
      # Should I commetn this?
      @order.billing_address = Forms::BillingAddressForm.from_model(current_order.billing_address)
      @order.shipping_address = Forms::ShippingAddressForm.from_model(current_order.shipping_address)
      # if @current_order.billing_address
      #   @order.billing_address = Forms::BillingAddressForm.from_model(@current_order.billing_address)
      # else
      #   @order.billing_address = Forms::BillingAddressForm.new
      # end
      # @order[:use_billing_address_as_shipping] = 'true' if @current_order.use_billing_address_as_shipping

      # if @current_order.shipping_address
      #   @order.billing_address = Forms::BillingAddressForm.from_params(@current_order.billing_address)
      # else
      #   @order.billing_address = Forms::BillingAddressForm.new
      # end
      # @order.shipping_address = Forms::ShippingAddressForm.new
    when :delivery # then Forms::DeliveryForm
      @order = current_order # @shipping_method = Forms::ShippingMethodForm.new
      @order.shipping_method ||= ShippingMethod.order(:price).first
    when :payment
      @order = current_order
      @payment = Forms::PaymentForm.new
    when :confirm
      @order = current_order
    when :complete
      current_order.pay if current_order.may_pay?
      @order = current_order
    end

    render_wizard
  end


  def update
    @current_order = current_order
    case step
    when :address
      if params[:order][:use_billing_address_as_shipping] == 'true'
        use_billing = true
      else
        use_billing = false
      end
      @order = Forms::OrderForm.from_params(params[:order], id: current_order.id)
              .with_context(use_billing_address_as_shipping: use_billing)
      render_wizard @order
      # current_order.update_attributes(use_billing_address_as_shipping: use_billing)
      # @billing_address = Forms::BillingAddressForm
      #         .from_params(params[:order][:billing_address], order_id: current_order.id,
      #                       type: 'BillingAddress')
      # @shipping_address = Forms::ShippingAddressForm
      #         .from_params(params[:order][:shipping_address], order_id: current_order.id,
      #                       type: 'ShippingAddress')
    when :delivery then
      current_order.update_attributes(shipping_method_id: params[:order][:shipping_method_id])
      @order = current_order
      render_wizard @order
    when :payment
      @payment = Forms::PaymentForm.from_params(params[:payment])
      render_wizard @payment
    when :confirm
      @order = current_order
      render_wizard @order
    when :complete
    end
  end

  # def create
  #   @form = Forms::AddressForm.from_params(params)
  #
  #   respond_to do |format|
  #     if @form.valid?
  #       format.html { redirect_to next_wizard_path, notice:
  #       'Address has been successfully saved' }
  #       # format.json { render :show, status: :created,
  #       # location: @order }
  #     else
  #       format.html { redirect_to wizard_path }
  #       # format.json { render json: @order.errors,
  #       # status: :unprocessable_entity }
  #     end
  #   end

    # respond_to do |format|
    #   if @order.save
    #     Cart.destroy(session[:cart_id])
    #     session[:cart_id] = nil
    #     format.html { redirect_to store_index_url, notice:
    #     'Thank you for your order.' }
    #     format.json { render :show, status: :created,
    #     location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors,
    #     status: :unprocessable_entity }
    #   end
    # end
  # end

  # def edit
  #   render_wizard @form
  #   # @form = Forms::AddressForm.from_model(model)
  # end


  # def form
  #   @form = form_object.from_model(model)
  # end

  # private

    # def form
    #   @form = form_object.new(model)
    # end
    #
    # def form_object
    #   case step
    #   when :address then Forms::BillingAddressForm
    #   when :delivery then Forms::DeliveryForm
    #   when :payment then Forms::PaymentForm
    #   when :confirm then Forms::ConfirmForm
    #   when :complete then Forms::CompleteForm
    #   end
    # end
    #
    # def model
    #   @model = case step
    #     when :address then current_user.billing_address
    #     when :delivery then Forms::DeliveryForm
    #     when :payment then Forms::PaymentForm
    #     when :confirm then Forms::ConfirmForm
    #     when :complete then Forms::CompleteForm
    #   end
    # end

    # def set_attributes_from_model(attribute)
    #   raise RuntimeError, attribute unless respond_to?(attribute)
    #   current_user.send(attribute)
    # end
end
