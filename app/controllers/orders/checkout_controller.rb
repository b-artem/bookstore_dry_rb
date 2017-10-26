class Orders::CheckoutController < ApplicationController
  include Wicked::Wizard
  include CurrentOrder

  before_action :authenticate_user!
  authorize_resource(Order)
  authorize_resource(Address)

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @current_order = current_order
    case step
    when :address
      load_addresses
    when :delivery
      load_delivery
    when :payment, :confirm
      load_payment
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
      save_addresses
    when :delivery then
      current_order.update_attributes(shipping_method_id: params[:order][:shipping_method_id])
      render_next_step current_order
    when :payment
      process_payment
    when :confirm
      @order = current_order
      render_wizard @order
    when :complete
      clear_payment_data
    end
  end

  private

    def load_addresses
      @order = Forms::OrderForm.from_model(current_order)
      billing_model = current_order.billing_address || current_user.billing_address
      shipping_model = current_order.shipping_address || current_user.shipping_address
      @order.billing_address = Forms::BillingAddressForm.from_model(billing_model)
      @order.shipping_address = Forms::ShippingAddressForm.from_model(shipping_model)
    end

    def save_addresses
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
    end

    def load_delivery
      @order = current_order
      @order.shipping_method ||= ShippingMethod.order(:price).first
      @shipping_methods = ShippingMethod.order('price ASC')
    end

    def load_payment
      @order = current_order
      @payment = Forms::PaymentForm.new
      get_payment_data
    end

    def process_payment
      @order = current_order
      @payment = Forms::PaymentForm.from_params(params[:payment])
      set_payment_data
      render_next_step @payment
    end

    def render_next_step(form)
      return render_wizard(form) unless form.valid?
      form.save
      return redirect_to next_wizard_path unless params[:next_step] == 'confirm'
      redirect_to wizard_path(:confirm)
    end

    def set_payment_data
      session[:card_number] = @payment.card_number
      session[:name_on_card] = @payment.name_on_card
      session[:valid_until] = @payment.valid_until
      session[:cvv] = @payment.cvv
    end

    def clear_payment_data
      session.delete :card_number
      session.delete :name_on_card
      session.delete :valid_until
      session.delete :cvv
    end

    def get_payment_data
      @payment.card_number = session[:card_number]
      @payment.name_on_card = session[:name_on_card]
      @payment.valid_until = session[:valid_until]
      @payment.cvv = session[:cvv]
    end
end
