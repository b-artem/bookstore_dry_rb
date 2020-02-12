class OrderForm < ApplicationForm
  attribute :id, Types::Integer
  attribute :billing_address?, BillingAddressForm
  attribute :shipping_address?, ShippingAddressForm
  attribute :use_billing_address_as_shipping?, Types::Bool

  def save
    return false unless valid?

    Order.find(id).update(use_billing_address_as_shipping: use_billing_address_as_shipping)
    ShippingAddress.create(shipping_address.attributes) unless use_billing_address_as_shipping
    BillingAddress.create(billing_address.attributes)
  end

  def valid?
    billing_address.valid?
    shipping_address&.valid? unless use_billing_address_as_shipping

    attrs = NestedStructsToHash.call(attributes)
    errors = OrderContract.new.call(attrs).errors.to_h
    errors = errors.except(:shipping_address) if use_billing_address_as_shipping

    @errors = errors
    errors.empty?
  end
end
