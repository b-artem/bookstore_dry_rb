class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  ROLES = %i[admin user].freeze

  has_many :orders
  has_many :reviews
  has_one :billing_address
  has_one :shipping_address

  def self.from_omniauth(auth)
    where(omniauth_provider: auth.provider,
          omniauth_uid: auth.uid).first_or_create do |user|
      user.omniauth_provider = auth.provider
      user.omniauth_uid = auth.uid
      user.email = (auth.info.email || auth.info.first_name + auth.info.last_name + '@fb.com')
      user.skip_confirmation!
      user.password = Devise.friendly_token[0, 20]
      user.image_url = auth.info.image
    end
  end
end
