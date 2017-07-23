require 'rails_helper'

RSpec.describe User, type: :model do
  # subject { FactoryGirl.build :user }
  # let(:user) { FactoryGirl.create :user }

  # it 'is invalid without an email' do
  #   expect(FactoryGirl.build :user, email: nil).not_to be_valid
  # end
  #
  # it 'does not allow duplicate emails' do
  #   expect(FactoryGirl.build :user, email: user.email).not_to be_valid
  # end

  context ':email' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:email) }
  end

  context ':password' do
    it { is_expected.to validate_presence_of(:password) }
  end
end
