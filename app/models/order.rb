class Order < ApplicationRecord
  belongs_to :user
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  # accepts_nested_attributes_for :billing_address, :shipping_address
  belongs_to :shipping_method, optional: true
  has_many :line_items, dependent: :destroy
end
