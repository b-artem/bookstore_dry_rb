FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '12345678'

    # factory :admin do
    #   admin true
    # end

    # factory :author do
    #   ignore do
    #     posts_count 5
    #   end
    #
    #   after(:create) do |user, evaluator|
    #     create_list(:post, evaluator.posts_count, user: user)
    #   end
    # end
  end
end
