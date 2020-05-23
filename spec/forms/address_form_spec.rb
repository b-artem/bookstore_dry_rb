# frozen_string_literal: true

require 'support/factory_girl'
require 'support/dry_validation/shared_examples'

RSpec.describe AddressForm do
  let(:form) { described_class }
  let(:attributes) { attributes_for(:address).merge(order_id: 1) }

  context 'when attributes are valid' do
    it 'is valid' do
      expect(form.new(attributes)).to be_valid
    end
  end

  context 'Type' do
    it 'allows only BillingAddress or ShippingAddress' do
      expect(form.new(attributes.merge(type: %w[BillingAddress ShippingAddress].sample))).to be_valid

      invalid_form = form.new(attributes.merge(type: Faker::Lorem.word))
      invalid_form.valid?
      expect(invalid_form.errors.keys).to contain_exactly :type
    end
  end

  context 'Presence' do
    include_examples 'validates presence of', :type
    include_examples 'validates presence of', :first_name
    include_examples 'validates presence of', :last_name
    include_examples 'validates presence of', :address
    include_examples 'validates presence of', :city
    include_examples 'validates presence of', :zip
    include_examples 'validates presence of', :country
    include_examples 'validates presence of', :phone
  end

  context 'Format' do
    include_examples 'allows value', :first_name, 'Anna'
    include_examples 'not allow value', :first_name, 'Anna-Maria'

    include_examples 'allows value', :last_name, 'Musk'
    include_examples 'not allow value', :last_name, 'Musk2'

    include_examples 'allows value', :address, 'a-z, A-Z, 0-9'
    include_examples 'not allow value', :address, '/'

    include_examples 'allows value', :city, 'Buenos Aires'
    include_examples 'not allow value', :city, 'Buenos-Aires'

    include_examples 'allows value', :zip, '123-456'
    include_examples 'not allow value', :zip, '123 456'

    include_examples 'allows value', :country, 'South Africa'
    include_examples 'not allow value', :country, 'South-Africa'

    include_examples 'allows value', :phone, '+380123456789'
    include_examples 'not allow value', :phone, '380123456789'
    include_examples 'not allow value', :phone, '+380 12 345 67 89'
    include_examples 'not allow value', :phone, '+380(12)3456789'
    include_examples 'not allow value', :phone, '+380-12-345-67-89'
  end
end
