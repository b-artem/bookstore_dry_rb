class LineItem < ApplicationRecord
  belongs_to :book  #, optional: true
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1  }

  def subtotal
    price * quantity
  end
end
