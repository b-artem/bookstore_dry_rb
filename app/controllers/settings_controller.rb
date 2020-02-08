class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update update_email change_password]
  before_action :set_addresses, only: :edit

  def edit; end

  def update_email
    if @user.update(user_params)
      redirect_to settings_edit_path(tab: 'privacy'),
                  notice: t('.success')
    else
      redirect_to settings_edit_path(tab: 'privacy'),
                  alert: t('.fail')
    end
  end

  def change_password
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to settings_edit_path(tab: 'privacy'),
                  notice: t('.success')
    else
      redirect_to settings_edit_path(tab: 'privacy'),
                  alert: t('.fail')
    end
  end

  def update
    address = AddressForm.new(params[:address].to_unsafe_h.merge(user_id: @user.id))
    if address.save
      redirect_to settings_edit_path, notice: t('.success')
    else
      redirect_to settings_edit_path(settings_params), alert: t('.fail')
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def settings_params
    params.permit(address: %i[type first_name last_name address city zip country phone])
  end

  def set_addresses
    if params.dig(:address, :type) == 'BillingAddress'
      @billing_address = AddressForm.new(params[:address].to_unsafe_h)
      @billing_address.valid?
    else
      @billing_address = @user.billing_address
    end

    if params.dig(:address, :type) == 'ShippingAddress'
      @shipping_address = AddressForm.new(params[:address].to_unsafe_h)
      @shipping_address.valid?
    else
      @shipping_address = @user.shipping_address
    end
  end
end
