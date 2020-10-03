# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "Review no. #{n}" }
    content { Faker::Lorem.paragraph }
    book { build :book }
    user { create :user }
  end
end
