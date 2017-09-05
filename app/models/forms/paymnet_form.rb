module Forms
  class PaymentForm < Rectify::Form
    attribute :card_number, Integer
    attribute :name_on_card, String
    attribute :valid_until, String
    attribute :cvv, String
  end
end
