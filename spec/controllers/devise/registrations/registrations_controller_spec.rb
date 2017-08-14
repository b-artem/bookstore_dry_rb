require 'support/devise'
require 'support/factory_girl'

describe Devise::RegistrationsController, type: :controller do
  let(:password) { Faker::Internet.password(8) }

  before do
    # allow(User).to receive(:new).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :new
    # get :new, params: {}, session: valid_session
  end

  describe 'GET #new' do
    it "returns a success response" do
      expect(response).to be_success
    end
  end
end
