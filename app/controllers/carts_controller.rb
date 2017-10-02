class CartsController < ApplicationController
  include CurrentCart
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  authorize_resource

  def show
  end

  def update
    coupon = Coupon.find_by_code(params[:cart][:coupon][:code])
    respond_to do |format|
      if coupon
        @cart.update(coupon: coupon)
        format.html { redirect_to @cart, notice: t('.success') }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { redirect_to @cart, alert: t('.fail') }
        format.json { render :show, status: :unprocessable_entity, location: @cart }
      end
    end
  end

  private

    def cart_params
      params.require(:cart).permit(:coupon)
    end

    def invalid_cart
      logger.error t('.access_ivalid_cart', cart_id: params[:id])
      redirect_back fallback_location: root_path, notice: t('.invalid_cart')
    end
end
