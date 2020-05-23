# frozen_string_literal: true

FactoryGirl.define do
  factory :image do
    book
    image_url { 'https://images-na.ssl-images-amazon.com/images/I/517JAFQLpdL.jpg' }
  end
end
