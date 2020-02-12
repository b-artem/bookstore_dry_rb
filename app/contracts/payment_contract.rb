class PaymentContract < ApplicationContract
  config.messages.namespace = :payment

  params(PaymentSchema)

  rule(:valid_until) do
    valid_terms = (0..120).each_with_object([]) do |val, arr|
      arr << (Time.zone.today + val.months).strftime('%m/%y')
    end

    key.failure(:invalid_term) unless valid_terms.include? value
  end
end
