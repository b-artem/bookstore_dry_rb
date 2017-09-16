FactoryGirl.define do
  factory :address_form, class: Forms::AddressForm do
    type { %w(BillingAddress ShippingAddress).sample }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip }
    country { Faker::Address.country }
    phone '+380123456789'
    order_id { create(:order).id }
  end
end
