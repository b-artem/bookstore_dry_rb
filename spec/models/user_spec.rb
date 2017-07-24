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
    # it { is_expected.to allow_value('http://foo.com').for(:email) }
  end

  context ':password' do
    # Should be masked.
    # Minimum 8 letters, at least 1 uppercase, at least 1 lowercase, at least 1 number.
    # Mustn't contain spaces inside
    # Spaces at the beginning and at the end should be cut off.

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }



  end
end
