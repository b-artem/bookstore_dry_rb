class Forms::AddressForm < Rectify::Form

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String

  validates :first_name, presence: true
  validates :last_name, presence: true

end
