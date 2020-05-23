# frozen_string_literal: true

require 'support/dry_validation/shared_examples'
require 'support/dry_validation/payment_info'

RSpec.describe PaymentForm do
  let(:form) { described_class }
  let(:attributes) { payment_info }

  include_context 'payment info'

  context 'when attributes are valid' do
    it 'is valid' do
      expect(form.new(attributes)).to be_valid
    end
  end

  context 'Presence' do
    include_examples 'validates presence of', :card_number
    include_examples 'validates presence of', :name_on_card
    include_examples 'validates presence of', :valid_until
    include_examples 'validates presence of', :cvv
  end

  context 'Format' do
    include_examples 'allows value', :card_number, '1234567812345678'
    include_examples 'not allow value', :card_number, '1234-5678-1234-5678'
    include_examples 'not allow value', :card_number, '1234 5678 1234 5678'

    include_examples 'allows value', :name_on_card, 'Elon Musk'
    include_examples 'not allow value', :name_on_card, 'Elon-Musk'

    include_examples 'allows value', :valid_until, Time.zone.today.strftime('%m/%y')
    include_examples 'allows value', :valid_until, (Time.zone.today + 120.months).strftime('%m/%y')
    include_examples 'not allow value',
                     :valid_until, (Time.zone.today + 121.months).strftime('%m/%y'),
                     :invalid_term
    include_examples 'not allow value',
                     :valid_until, (Time.zone.today - 1.month).strftime('%m/%y'),
                     :invalid_term
    include_examples 'not allow value',
                     :valid_until, Time.zone.today.strftime('%m/%Y'),
                     :invalid_term
    include_examples 'not allow value',
                     :valid_until, Time.zone.today.strftime('%m%y'),
                     :invalid_term

    include_examples 'allows value', :cvv, '123'
    include_examples 'allows value', :cvv, '1234'
    include_examples 'not allow value', :cvv, 'a123'
    include_examples 'not allow value', :cvv, '12-3'
  end
end
