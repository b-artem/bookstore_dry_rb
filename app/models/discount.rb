class Discount < ApplicationRecord
  has_many :orders

  validates :code, :amount, :valid_until, presence: true
  validates :code,
            format: { with: /\A[a-zA-Z0-9]+\z/,
                      message: 'Only allows letters and numbers' },
            length: { minimum: 8, maximum: 12 }
  validates :amount,
            numericality: { greater_than_or_equal_to: 0.001,
                            less_than_or_equal_to: 1 }
end
