class Forms::AddressForm < Rectify::Form

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String
  attribute :order_id, Integer

  validates :first_name, presence: true
  validates :last_name, presence: true

  def save
    if valid?
      binding.pry
      billing_address = BillingAddress.create(self.attributes)
      # billing_address.update
      billing_address.order_id = current_order.id
      flash[:alert] = 'Billing address was not saved' unless billing_address.save
      true
    else
      false
    end
  end

end
