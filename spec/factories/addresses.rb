FactoryGirl.define do
  factory :address do
    type { %w(BillingAddress ShippingAddress).sample }
  end
end
