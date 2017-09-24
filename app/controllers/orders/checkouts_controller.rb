class Orders::CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CurrentOrder
  require 'pry'

  authorize_resource(Order)
  authorize_resource(Address)
  # include Rectify::ControllerHelpers
  # before_action :set_form, only: [:show]
  steps :address, :delivery, :payment, :confirm, :complete

  # after_action :return_to_confirm?, only: [:update]

  def show
    @current_order = current_order
    case step
    when :address
      @order = Forms::OrderForm.from_model(current_order)
      billing_model = current_order.billing_address  || current_user.billing_address
      shipping_model = current_order.shipping_address || current_user.shipping_address
      @order.billing_address = Forms::BillingAddressForm.from_model(billing_model)
      @order.shipping_address = Forms::ShippingAddressForm.from_model(shipping_model)
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
      get_payment_data
    when :confirm
      @order = current_order
      @payment = Forms::PaymentForm.new
      get_payment_data
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
      @order.billing_address.order_id = current_order.id
      @order.shipping_address.order_id = current_order.id unless use_billing
      render_next_step @order
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
      render_next_step @order
    when :payment
      @payment = Forms::PaymentForm.from_params(params[:payment])
      set_payment_data
      render_next_step @payment
    when :confirm
      # get_payment_data
      @order = current_order
      render_wizard @order
    when :complete
      clear_payment_data
    end
  end

  private

    def render_next_step(form)
      if form.valid?
        form.save
        return redirect_to next_wizard_path unless params[:next_step] == 'confirm'
        redirect_to wizard_path(:confirm)
      else
        render_wizard form
      end
    end

    # def return_to_confirm?
    #   return if step == :confirm
    #   return unless params[:return_to_confirm] = 'true'
    #   params.delete :return_to_confirm
    #   jump_to :confirm
    # end

    def set_payment_data
      session[:card_number] = @payment.card_number
      session[:name_on_card] = @payment.name_on_card
      session[:valid_until] = @payment.valid_until
      session[:cvv] = @payment.cvv
    end

    def clear_payment_data
      session[:card_number] = nil
      session[:name_on_card] = nil
      session[:valid_until] = nil
      session[:cvv] = nil
    end

    def get_payment_data
      @payment.card_number = session[:card_number]
      @payment.name_on_card = session[:name_on_card]
      @payment.valid_until = session[:valid_until]
      @payment.cvv = session[:cvv]
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
