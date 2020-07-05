# frozen_string_literal: true

class OrderContract < ApplicationContract
  config.messages.namespace = :order

  params(OrderSchema)

  rule(:shipping_address) do
    key.failure(:attr?) if !values[:use_billing_address_as_shipping] && !value
  end
end
