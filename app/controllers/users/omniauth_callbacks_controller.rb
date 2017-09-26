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

# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def facebook
#     @user = User.from_omniauth(request.env["omniauth.auth"])
#     return sign_in_and_redirect @user if @user.email
#     flash[:warning] = "No email provided by facebook"
#     redirect_to request.env['omniauth.origin'] || root_path
#   end
#
#   def failure
#     redirect_to root_path
#   end
# end
