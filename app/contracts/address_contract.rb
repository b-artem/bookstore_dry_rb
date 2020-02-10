class AddressContract < ApplicationContract
  config.messages.namespace = :address

  params(AddressSchema, AddressFormSchema)

  rule(:order_id, :user_id) do
    base.failure(:no_association) if !value && !values[:user_id]
  end
end
