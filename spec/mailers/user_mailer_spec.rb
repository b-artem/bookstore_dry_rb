require 'rails_helper'
require 'support/factory_girl'

RSpec.describe UserMailer do
  describe 'email_changed' do
    let(:user) { build(:user) }
    let(:mail) { described_class.email_changed(user) }

    it 'renders the headers' do
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['notifications@bookstore-artem.herokuapp.com'])
    end
  end
end
