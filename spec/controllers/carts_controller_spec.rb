require 'rails_helper'
require 'support/devise'
require 'support/factory_girl'

RSpec.describe CartsController, type: :controller do
  let(:cart) { create :cart }
  let(:valid_attributes) { attributes_for :cart }
  let(:invalid_attributes) do
    valid_attributes.delete(valid_attributes.keys.sample)
  end
  let(:coupon) { build :coupon }
  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: cart.to_param }, session: valid_session
      expect(response).to have_http_status 200
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let!(:new_attributes) { attributes_for :cart }
      it 'updates the requested line_item' do
        put :update, params: { id: cart.to_param, cart: new_attributes
                               .merge(coupon: attributes_for(:coupon)) },
                     session: valid_session

        cart.reload
        binding.pry
        # coupon.attributes.each do |key, value|
          expect(cart.coupon).to eq coupon
        # end
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
end
