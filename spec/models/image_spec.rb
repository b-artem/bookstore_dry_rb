require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Image do
  let(:image) { build(:image) }

  it 'has a valid factory' do
    expect(image).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:book) }
  end
end
