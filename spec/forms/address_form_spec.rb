require 'rails_helper'
require 'support/factory_girl'
require 'support/i18n'

RSpec.shared_examples :validates_presence_of do |attr|
  it "validates presence of #{attr}" do
    attrs = attributes.except(attr)
    expect(form.new(attrs)).not_to be_valid
  end
end

RSpec.shared_examples :allows_value do |attr, value|
  it "allows value #{value} for #{attr}" do
    form = described_class.new(attributes.merge(attr => value))
    form.valid?
    expect(form.errors).to eq({})
  end
end

RSpec.shared_examples :not_allow_value do |attr, value|
  it "does not allow value #{value} for #{attr}" do
    form = described_class.new(attributes.merge(attr => value))
    form.valid?
    expect(form.errors).to eq(attr => [t("dry_validation.errors.address.rules.#{attr}.format?")])
  end
end

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
    include_examples :validates_presence_of, :type
    include_examples :validates_presence_of, :first_name
    include_examples :validates_presence_of, :last_name
    include_examples :validates_presence_of, :address
    include_examples :validates_presence_of, :city
    include_examples :validates_presence_of, :zip
    include_examples :validates_presence_of, :country
    include_examples :validates_presence_of, :phone
  end

  context 'Format' do
    include_examples :allows_value, :first_name, 'Anna'
    include_examples :not_allow_value, :first_name, 'Anna-Maria'

    include_examples :allows_value, :last_name, 'Musk'
    include_examples :not_allow_value, :last_name, 'Musk2'

    include_examples :allows_value, :address, 'a-z, A-Z, 0-9'
    include_examples :not_allow_value, :address, '/'

    include_examples :allows_value, :city, 'Buenos Aires'
    include_examples :not_allow_value, :city, 'Buenos-Aires'

    include_examples :allows_value, :zip, '123-456'
    include_examples :not_allow_value, :zip, '123 456'

    include_examples :allows_value, :country, 'South Africa'
    include_examples :not_allow_value, :country, 'South-Africa'

    include_examples :allows_value, :phone, '+380123456789'
    include_examples :not_allow_value, :phone, '380123456789'
    include_examples :not_allow_value, :phone, '+380 12 345 67 89'
    include_examples :not_allow_value, :phone, '+380(12)3456789'
    include_examples :not_allow_value, :phone, '+380-12-345-67-89'
  end
end
