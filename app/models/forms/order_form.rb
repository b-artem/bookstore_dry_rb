class Forms::OrderForm < Rectify::Form

  attribute :billing_address, Forms::BillingAddressForm
  attribute :shipping_address, Forms::ShippingAddressForm
  attribute :use_billing_address_as_shipping, Boolean

  validates :billing_address, presence: true
  validates :shipping_address, presence: true, if: :need_shipping_address?

  def save
    if valid?
      binding.pry
      true
    else
      false
    end
  end

  def need_shipping_address?
    true unless use_billing_address_as_shipping
  end

end
