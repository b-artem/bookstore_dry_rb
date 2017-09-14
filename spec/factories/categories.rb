FactoryGirl.define do
  factory :category do
    name { %w['Mobile development' Photo, 'Web design', 'Web development'].sample }
  end

  # factory :category_mobile_development, class: Category do
  #   name 'Mobile development'
  #   # initialize_with { Category.find_or_create_by(name: name) }
  # end
  #
  # factory :category_photo, class: Category do
  #   name 'Photo'
  # end
  #
  # factory :category_web_design, class: Category do
  #   name 'Web design'
  # end
  #
  # factory :category_web_development, class: Category do
  #   name 'Web development'
  # end
end
