class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    unless request.env["omniauth.auth"].info.email
      flash[:warning] = "No email provided by facebook. Custom email created. Please change it in settings"
    end
    sign_in_and_redirect @user
  end

  def failure
    flash[:warning] = 'Failed to sign in'
    redirect_to root_path
  end
end
