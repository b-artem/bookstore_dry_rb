class Orders::CheckoutsController < ApplicationController
  include Wicked::Wizard
  include CurrentOrder
  require 'pry'
  # include Rectify::ControllerHelpers
  # before_action :set_form, only: [:show]
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @billing_address = Forms::BillingAddressForm.new
    @shipping_address = Forms::ShippingAddressForm.new
    # set_attributes_from_model(step)
    # binding.pry
    render_wizard
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

  def update
    case step
    when :address
      @billing_address = Forms::AddressForm
              .from_params(params[:billing_address], order_id: current_order.id,
                            type: 'BillingAddress')
      @shipping_address = Forms::AddressForm
              .from_params(params[:shipping_address], order_id: current_order.id,
                            type: 'ShippingAddress')
    when :delivery then Forms::DeliveryForm
    when :payment then Forms::PaymentForm
    when :confirm then Forms::ConfirmForm
    when :complete then Forms::CompleteForm
    end
    if @billing_address.save
      render_wizard @shipping_address
    else
      render_wizard @billing_address
    end
  end

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
