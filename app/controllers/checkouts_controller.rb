class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @form = Forms::CheckoutForm.new
    render_wizard
  end

  def new

  end

  def create



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

  def update

  end
end
