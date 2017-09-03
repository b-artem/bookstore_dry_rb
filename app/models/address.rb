class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders

  # def self.types
  #   %w(BillingAddress ShippingAddress)
  # end
end
