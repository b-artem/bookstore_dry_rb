FactoryGirl.define do
  factory :review do
    title "MyString"
    text "MyText"
    score 1
    status "MyString"
    book nil
    user nil
  end
end
