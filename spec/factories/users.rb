FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '12345678'

    factory :admin do
      role 'admin'
    end
  end
end
