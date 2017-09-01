class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1  }

  def subtotal
    book.price * quantity
  end
end
