class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  authorize_resource

  def show
  end

  private

    def cart_params
      params.require(:cart).permit(:coupon)
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_back fallback_location: root_path, notice: 'Invalid cart'
    end
end
