class Address < ApplicationRecord
  belongs_to :user, optional: true

  def self.types
    %w(BillingAddress ShippingAddress)
  end
end
