FactoryGirl.define do
  factory :order do
    number "MyString"
    completed_at "2017-09-02 22:31:47"
    state "MyString"
    user nil
    billing_address nil
    shipping_address nil
    shipping_method nil
  end
end
