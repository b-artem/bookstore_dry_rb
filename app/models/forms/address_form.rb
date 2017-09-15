class Forms::AddressForm < Rectify::Form

  attribute :type, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String
  attribute :order_id, Integer

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone,
            presence: true, if: :need_shipping_address?

  def need_shipping_address?
    return if type == 'ShippingAddress' && context.use_billing_address_as_shipping
    true
  end

  # def save
  #   if valid?
  #     Address.create(attributes)
  #     true
  #   else
  #     false
  #   end
  # end

end
