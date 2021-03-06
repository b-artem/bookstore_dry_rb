# frozen_string_literal: true

require 'rails_helper'
require 'support/i18n'

RSpec.shared_examples 'validates presence of' do |attr|
  it "validates presence of #{attr}" do
    attrs = attributes.except(attr)
    expect(form.new(attrs)).not_to be_valid
  end
end

RSpec.shared_examples 'allows value' do |attr, value|
  it "allows value #{value} for #{attr}" do
    form = described_class.new(attributes.merge(attr => value))
    form.valid?
    expect(form.errors).to eq({})
  end
end

RSpec.shared_examples 'not allow value' do |attr, value, rule_key|
  it "does not allow value #{value} for #{attr}" do
    form = described_class.new(attributes.merge(attr => value))
    form.valid?

    key = rule_key || :format?
    i18n_path = "dry_validation.errors.#{described_class.to_s.chomp('Form').underscore}.rules.#{attr}.#{key}"
    expect(form.errors).to eq(attr => [t(i18n_path)])
  end
end
