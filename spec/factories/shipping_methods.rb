FactoryGirl.define do
  factory :shipping_method do
    name "MyString"
    days_min 1
    days_max 1
    price 1.5
  end
end
