class Forms::PaymentForm < Rectify::Form

  attribute :card_number, String
  attribute :name_on_card, String
  attribute :valid_until, String
  attribute :cvv, String

  validates :card_number, :name_on_card, :valid_until, :cvv,
            presence: true
  validates :card_number,
            format: { with: /\A[0-9]{8,19}\z/, message: 'Only allows 0-9' }
  validates :name_on_card,
            format: { with: /\A[A-Z a-z]+\z/, message: 'Only allows letters and spaces' },
            length: { maximum: 49 }
  validates :name_on_card,
            format: { with: /\A[A-Z a-z]+\z/, message: 'Only allows letters and spaces' },
            length: { maximum: 49 }
  validates_with Concerns::PaymentValidator, fields: [:valid_until]
  validates :cvv,
            format: { with: /\A[0-9]+\z/, message: 'Only allows 0-9' },
            length: { minimum: 3 }

  def save
    if valid?
      true
    else
      false
    end
  end
end
