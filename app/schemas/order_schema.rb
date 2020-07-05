# frozen_string_literal: true

OrderSchema = Dry::Schema.Params do
  required(:billing_address).hash(AddressSchema)
  optional(:shipping_address).hash(AddressSchema)
  required(:use_billing_address_as_shipping).filled(:bool)
end
