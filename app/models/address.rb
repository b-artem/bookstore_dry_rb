class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :type, inclusion: { in: %w(BillingAddress ShippingAddress),
    message: "%{value} is not a valid type" }
    
  # def self.types
  #   %w(BillingAddress ShippingAddress)
  # end
end
