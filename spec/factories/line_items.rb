FactoryGirl.define do
  factory :line_item do
    book { build(:book) }
    cart { build(:cart) }
    quantity 1
  end
end
