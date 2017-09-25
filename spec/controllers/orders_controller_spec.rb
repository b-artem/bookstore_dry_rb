require 'rails_helper'
require 'support/devise'

RSpec.describe Orders::OrdersController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :show, params: {id: order.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :edit, params: {id: order.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, params: {order: valid_attributes}, session: valid_session
        }.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post :create, params: {order: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {order: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested order" do
        order = Order.create! valid_attributes
        put :update, params: {id: order.to_param, order: new_attributes}, session: valid_session
        order.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the order" do
        order = Order.create! valid_attributes
        put :update, params: {id: order.to_param, order: valid_attributes}, session: valid_session
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        order = Order.create! valid_attributes
        put :update, params: {id: order.to_param, order: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested order" do
      order = Order.create! valid_attributes
      expect {
        delete :destroy, params: {id: order.to_param}, session: valid_session
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order = Order.create! valid_attributes
      delete :destroy, params: {id: order.to_param}, session: valid_session
      expect(response).to redirect_to(orders_url)
    end
  end

end
