require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Author, type: :model do
  let(:author) { build :author }

  it 'has valid factory' do
    expect(author).to be_valid
  end
end
