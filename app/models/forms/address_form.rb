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

  validates :first_name, presence: true
  validates :last_name, presence: true

  def save
    if valid?
      Address.create(attributes)
      true
    else
      false
    end
  end

end
