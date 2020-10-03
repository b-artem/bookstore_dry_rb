# frozen_string_literal: true

FactoryGirl.define do
  factory :line_item do
    book { build(:book) }
    cart { build(:cart) }
    price { book.price }
    quantity { 1 }

    trait :with_cover do
      association :book, factory: %i[book with_cover]
    end
  end
end
