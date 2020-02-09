require_relative '../schemas/address_schema'

class BillingAddressContract < AddressContract
  # Contracts don't inherit schema from a parent
  params(AddressSchema, AddressFormSchema)

  rule(:type) do
    key.failure(:not_billing) if value != 'BillingAddress'
  end
end
