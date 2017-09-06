class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  # def self.types
  #   %w(BillingAddress ShippingAddress)
  # end
end
