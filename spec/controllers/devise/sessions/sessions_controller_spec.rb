require 'support/devise'
require 'support/factory_girl'

describe Devise::SessionsController, type: :controller do
  let(:user) { create :user }

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
