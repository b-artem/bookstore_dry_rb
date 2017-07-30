class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # binding.pry
    return sign_in_and_redirect @user if @user.email
    flash[:warning] = "No email provided by facebook"
    redirect_to request.env['omniauth.origin'] || root_path
  end
end
