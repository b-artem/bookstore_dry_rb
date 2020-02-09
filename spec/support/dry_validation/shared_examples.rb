require 'rails_helper'
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

RSpec.shared_examples :not_allow_value do |attr, value, rule_key|
  it "does not allow value #{value} for #{attr}" do
    form = described_class.new(attributes.merge(attr => value))
    form.valid?

    key = rule_key || :format?
    i18n_path = "dry_validation.errors.#{described_class.to_s.gsub('Form', '').underscore}.rules.#{attr}.#{key}"
    expect(form.errors).to eq(attr => [t(i18n_path)])
  end
end
