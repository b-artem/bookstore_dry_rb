class Order < ApplicationRecord
  belongs_to :user
  belongs_to :billing_address, foreign_key: 'billing_address_id', optional: true
  belongs_to :shipping_address, foreign_key: 'shipping_address_id', optional: true
  belongs_to :shipping_method, optional: true
  has_many :line_items, dependent: :destroy
end
