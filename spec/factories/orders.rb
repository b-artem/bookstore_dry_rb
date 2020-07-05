# frozen_string_literal: true

FactoryGirl.define do
  factory :order do
    user { build :user }
  end
end
