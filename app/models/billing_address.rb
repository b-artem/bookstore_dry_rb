class BillingAddress < Address
  has_many :orders
end
