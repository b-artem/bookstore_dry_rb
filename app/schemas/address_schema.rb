AddressSchema = Dry::Schema.Params do
  NAME_FORMAT = /\A[a-zA-Z]+\z/.freeze
  ADDRESS_FORMAT = /\A[A-Za-z0-9, -]+\z/.freeze
  CITY_FORMAT = /\A[A-Z a-z]+\z/.freeze
  ZIP_FORMAT = /\A[0-9-]+\z/.freeze
  PHONE_FORMAT = /\A\+{1}[0-9]+\z/.freeze

  required(:type).filled(included_in?: %w[BillingAddress ShippingAddress])

  required(:first_name).filled(format?: NAME_FORMAT, max_size?: 49)
  required(:last_name).filled(format?: NAME_FORMAT, max_size?: 49)
  required(:address).filled(format?: ADDRESS_FORMAT, max_size?: 49)
  required(:city).filled(format?: CITY_FORMAT, max_size?: 49)
  required(:zip).filled(format?: ZIP_FORMAT, max_size?: 10)
  required(:country).filled(format?: CITY_FORMAT, max_size?: 49)
  required(:phone).filled(format?: PHONE_FORMAT, max_size?: 15)
end
