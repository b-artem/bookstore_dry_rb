module Forms

  class CheckoutForm < Rectify::Form
    mimic :order

    attribute :first_name, String
    attribute :last_name, String
    attribute :address, String
    attribute :city, String
    attribute :zip, String
    attribute :country, String
    attribute :phone, String

    attribute :shipping_method, String

    attribute :card_number, Integer
    attribute :name_on_card, String
    attribute :valid_until, String
    attribute :cvv, String


    validates :first_name, presence: true
  end

end
