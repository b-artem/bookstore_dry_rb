FactoryGirl.define do
  factory :review do
    sequence :title { |n| "Review no. #{n}" }
    text { Faker::Lorem.paragraph }
    book { build :book }
    user { build_stubbed :user }
  end
end
