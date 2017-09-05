class Orders::CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    # @form = Forms::AddressForm.new
    @form = form
    # set_attributes_from_model(step)
    render_wizard
  end

  def new

  end

  def create
    @form = Forms::AddressForm.from_params(params)

    respond_to do |format|
      if @form.valid?
        format.html { redirect_to next_wizard_path, notice:
        'Address has been successfully saved' }
        # format.json { render :show, status: :created,
        # location: @order }
      else
        format.html { redirect_to wizard_path }
        # format.json { render json: @order.errors,
        # status: :unprocessable_entity }
      end
    end

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
  end

  def edit
    @form = Forms::AddressForm.from_model()
  end

  def update
    # @form = Forms::AddressForm.from_params(params)
    render_wizard
  end

  def form
    @form = form_object.from_model(model)
  end

  private



    def model
      @model = case step
      when :address then current_user.shipping_address
        when :delivery then Forms::DeliveryForm
        when :payment then Forms::PaymentForm
        when :confirm then Forms::ConfirmForm
        when :complete then Forms::CompleteForm
      end
    end

    def form_object
      case step
      when :address then Forms::AddressForm
      when :delivery then Forms::DeliveryForm
      when :payment then Forms::PaymentForm
      when :confirm then Forms::ConfirmForm
      when :complete then Forms::CompleteForm
      end
    end

    # def set_attributes_from_model(attribute)
    #   raise RuntimeError, attribute unless respond_to?(attribute)
    #   current_user.send(attribute)
    # end
end
