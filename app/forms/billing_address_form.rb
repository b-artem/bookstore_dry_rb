# frozen_string_literal: true

class BillingAddressForm < AddressForm
  def valid?
    @errors = BillingAddressContract.new.call(attributes).errors.to_h
    errors.empty?
  end
end
