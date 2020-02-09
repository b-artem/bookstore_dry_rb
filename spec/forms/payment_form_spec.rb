require 'support/dry_validation/shared_examples'
require 'support/dry_validation/payment_info'

RSpec.describe PaymentForm do
  let(:form) { described_class }

  include_context :payment_info
  let(:attributes) { payment_info }

  context 'when attributes are valid' do
    it 'is valid' do
      expect(form.new(attributes)).to be_valid
    end
  end

  context 'Presence' do
    include_examples :validates_presence_of, :card_number
    include_examples :validates_presence_of, :name_on_card
    include_examples :validates_presence_of, :valid_until
    include_examples :validates_presence_of, :cvv
  end

  context 'Format' do
    include_examples :allows_value, :card_number, '1234567812345678'
    include_examples :not_allow_value, :card_number, '1234-5678-1234-5678'
    include_examples :not_allow_value, :card_number, '1234 5678 1234 5678'

    include_examples :allows_value, :name_on_card, 'Elon Musk'
    include_examples :not_allow_value, :name_on_card, 'Elon-Musk'

    include_examples :allows_value, :valid_until, Time.zone.today.strftime('%m/%y').to_s
    include_examples :allows_value, :valid_until, (Time.zone.today + 120.months).strftime('%m/%y').to_s
    include_examples :not_allow_value,
                     :valid_until, (Time.zone.today + 121.months).strftime('%m/%y').to_s,
                     :invalid_term
    include_examples :not_allow_value,
                     :valid_until, (Time.zone.today - 1.month).strftime('%m/%y').to_s,
                     :invalid_term
    include_examples :not_allow_value,
                     :valid_until, Time.zone.today.strftime('%m/%Y').to_s,
                     :invalid_term
    include_examples :not_allow_value,
                     :valid_until, Time.zone.today.strftime('%m%y').to_s,
                     :invalid_term

    include_examples :allows_value, :cvv, '123'
    include_examples :allows_value, :cvv, '1234'
    include_examples :not_allow_value, :cvv, 'a123'
    include_examples :not_allow_value, :cvv, '12-3'
  end
end
