require 'rails_helper'
require 'support/devise'

RSpec.describe LineItemsController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #edit" do
    it "returns a success response" do
      line_item = LineItem.create! valid_attributes
      get :edit, params: {id: line_item.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    let(:line_item) { create :line_item }
    # subject { -> { line_item.create } }

    it "creates a new LineItem" do
      expect {
        post :create, params: {line_item: valid_attributes}, session: valid_session
      }.to change(LineItem, :count).by(1)
    end

    context "with valid params" do
      it "creates a new LineItem" do
        expect {
          post :create, params: {line_item: valid_attributes}, session: valid_session
        }.to change(LineItem, :count).by(1)
      end

      it "redirects to the created line_item" do
        post :create, params: {line_item: valid_attributes}, session: valid_session
        expect(response).to redirect_to(LineItem.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {line_item: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested line_item" do
        line_item = LineItem.create! valid_attributes
        put :update, params: {id: line_item.to_param, line_item: new_attributes}, session: valid_session
        line_item.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the line_item" do
        line_item = LineItem.create! valid_attributes
        put :update, params: {id: line_item.to_param, line_item: valid_attributes}, session: valid_session
        expect(response).to redirect_to(line_item)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        line_item = LineItem.create! valid_attributes
        put :update, params: {id: line_item.to_param, line_item: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested line_item" do
      line_item = LineItem.create! valid_attributes
      expect {
        delete :destroy, params: {id: line_item.to_param}, session: valid_session
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to the line_items list" do
      line_item = LineItem.create! valid_attributes
      delete :destroy, params: {id: line_item.to_param}, session: valid_session
      expect(response).to redirect_to(line_items_url)
    end
  end

end
