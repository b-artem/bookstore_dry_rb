class ApplicationController < ActionController::Base
  include CurrentCart
  protect_from_forgery with: :exception
  before_action :set_locale_from_params
  before_action :store_user_location, if: :storable_location?
  before_action :store_back_path, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_cart

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def set_locale_from_params
    return unless params[:locale]
    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, session)
  end

  private
    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      request.get? && !devise_controller? && !request.xhr?
    end

    def store_user_location
      store_location_for(:user, request.fullpath)
    end

    def store_back_path
      session[:back_path] = request.referer
    end
end
