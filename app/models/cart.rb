class Cart < ApplicationRecord
  include Validations
  has_many :line_items, dependent: :destroy

  def add_product(product, quantity)
    return unless positive_integer?(quantity)
    current_item = line_items.find_by(book_id: product.id)
    if current_item
      current_item.quantity += Integer(quantity)
    else
      current_item = line_items.build(book_id: product.id, quantity: quantity)
    end
    current_item
  end

  def subtotal
    return 0 unless line_items.any?
    line_items.decorate.sum(&:subtotal)
  end
end
