require 'rails_helper'
require 'support/devise'

RSpec.describe CartsController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #show" do
    it "returns a success response" do
      cart = Cart.create! valid_attributes
      get :show, params: {id: cart.to_param}, session: valid_session
      expect(response).to be_success
    end
  end
end
