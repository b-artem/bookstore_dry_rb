Figaro.require_keys("FACEBOOK_KEY", "FACEBOOK_SECRET")

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
            scope: 'public_profile', info_fields: 'id'
end
