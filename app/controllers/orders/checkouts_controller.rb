class Orders::CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CurrentOrder

  authorize_resource(Order)
  authorize_resource(Address)

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @current_order = current_order
    case step
    when :address
      @order = Forms::OrderForm.from_model(current_order)
      billing_model = current_order.billing_address  || current_user.billing_address
      shipping_model = current_order.shipping_address || current_user.shipping_address
      @order.billing_address = Forms::BillingAddressForm.from_model(billing_model)
      @order.shipping_address = Forms::ShippingAddressForm.from_model(shipping_model)
    when :delivery
      @order = current_order
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

    when :delivery then
      current_order.update_attributes(shipping_method_id: params[:order][:shipping_method_id])
      @order = current_order
      render_next_step @order
    when :payment
      @payment = Forms::PaymentForm.from_params(params[:payment])
      set_payment_data
      render_next_step @payment
    when :confirm
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
end
