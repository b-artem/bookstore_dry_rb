class ShippingAddressContract < AddressContract
  # Contracts don't inherit schema from a parent
  params(AddressSchema, AddressFormSchema)

  rule(:type) do
    key.failure(:not_shipping) if value != 'ShippingAddress'
  end
end
