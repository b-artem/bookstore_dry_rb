FactoryGirl.define do
  factory :line_item do
    book { build(:book) }
    cart { build(:cart) }
  end
end
