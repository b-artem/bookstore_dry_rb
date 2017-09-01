FactoryGirl.define do
  factory :book do
    sequence :title { |n| "Title #{n}" }
    sequence :description { |n| "Description of Book #{n}. " * 35 }
    price { rand(10.0..150.0) }
    image_url "https://images-na.ssl-images-amazon.com/images/I/51lOFSm9X6L._SX385_BO1,204,203,200_.jpg"
    publication_year { Date.today.year - rand(1..5) }
    dimensions "H: 9.0 x W: 7.0 x D: 0.9"
    materials "Paperback"
    # authors nil
    # categories nil
  end
end
