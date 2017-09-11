class Forms::PaymentForm < Rectify::Form
  attribute :card_number, Integer
  attribute :name_on_card, String
  attribute :valid_until, String
  attribute :cvv, String

  validates :card_number, presence: true
  validates :name_on_card, presence: true
  validates :valid_until, presence: true
  validates :cvv, presence: true

  def save
    valid? ? true : false
  end
end
