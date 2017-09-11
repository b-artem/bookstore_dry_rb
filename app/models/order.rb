class Order < ApplicationRecord
  belongs_to :user
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  # accepts_nested_attributes_for :billing_address, :shipping_address
  belongs_to :shipping_method, optional: true
  has_many :line_items, dependent: :destroy

  def shipping_address
    return super unless self[:use_billing_address_as_shipping]
    billing_address
  end

  def item_total
    return 0 unless line_items.any?
    line_items.sum(&:subtotal)
  end

  def order_total
    return item_total unless shipping_method
    item_total + shipping_method.price
  end

end
