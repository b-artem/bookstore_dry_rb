class ShippingAddress < Address
  has_many :orders
end
