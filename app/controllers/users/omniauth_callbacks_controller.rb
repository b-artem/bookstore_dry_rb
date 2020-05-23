class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    flash[:warning] = t '.no_email_provided' unless request.env['omniauth.auth'].info.email
    sign_in_and_redirect @user
  end

  def failure
    flash[:warning] = t '.failed_to_sign_in'
    redirect_to root_path
  end
end
