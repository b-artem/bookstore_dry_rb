class Forms::OrderForm < Rectify::Form

  attribute :billing_address, Forms::BillingAddressForm
  attribute :shipping_address, Forms::ShippingAddressForm

  # attribute :use_billing_address_as_shipping, Boolean
  attribute :strs, String

  validates :billing_address, presence: true
  validates :shipping_address, presence: true

  def save
    if valid?
      true
    else
      false
    end
  end

end
