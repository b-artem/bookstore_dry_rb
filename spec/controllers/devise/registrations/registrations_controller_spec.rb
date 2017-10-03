require 'support/devise'
require 'support/factory_girl'

describe Devise::RegistrationsController, type: :controller do
  let(:password) { Faker::Internet.password(8) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :new
  end

  describe 'GET #new' do
    it "returns a success response" do
      expect(response).to be_success
    end
  end
end
