# frozen_string_literal: true

AddressFormSchema = Dry::Schema.Params do
  optional(:order_id).maybe(:integer)
  optional(:user_id).maybe(:integer)
end
