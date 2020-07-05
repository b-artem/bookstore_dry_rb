# frozen_string_literal: true

PaymentSchema = Dry::Schema.Params do
  CARD_NUMBER_FORMAT = /\A[0-9]{8,19}\z/.freeze
  NAME_ON_CARD_FORMAT = /\A[A-Z a-z]+\z/.freeze
  CVV_FORMAT = /\A[0-9]+\z/.freeze

  required(:card_number).filled(format?: CARD_NUMBER_FORMAT)
  required(:name_on_card).filled(format?: NAME_ON_CARD_FORMAT, max_size?: 49)
  required(:valid_until).filled(:string)
  required(:cvv).filled(format?: CVV_FORMAT, min_size?: 3)
end
