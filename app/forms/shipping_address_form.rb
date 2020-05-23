# frozen_string_literal: true

class ShippingAddressForm < AddressForm
  def valid?
    @errors = ShippingAddressContract.new.call(attributes).errors.to_h
    errors.empty?
  end
end
