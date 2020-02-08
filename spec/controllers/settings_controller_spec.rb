require 'rails_helper'
require 'support/devise'
require 'support/factory_girl'

RSpec.describe SettingsController do
  let!(:user) { create(:user) }

  describe 'POST #update_email' do
    let(:email) { Faker::Internet.email }
    let(:valid_params) { { user: { email: email } } }
    let(:invalid_params) { { user: { email: 'wrong email' } } }

    before { sign_in user }

    context 'with valid params' do
      it 'shows message that confirmation link was sent' do
        post :update_email, params: valid_params
        expect(response).to redirect_to settings_edit_path(tab: 'privacy')
        expect(flash[:notice]).to eq I18n.t('settings.update_email.success')
      end
    end

    context 'with invalid params' do
      it 'shows fail message' do
        post :update_email, params: invalid_params
        expect(response).to redirect_to settings_edit_path(tab: 'privacy')
        expect(flash[:alert]).to eq I18n.t('settings.update_email.fail')
      end
    end
  end

  describe 'POST #change_password' do
    let(:password) { Faker::Internet.unique.password(8) }
    let(:user) { create(:user, password: password) }
    let(:new_password) { Faker::Internet.unique.password(8) }

    let(:valid_params) do
      {
        user: {
          current_password: password,
          password: new_password,
          password_confirmation: new_password
        }
      }
    end
    let(:invalid_params) { { user: { current_password: '', password: '' } } }

    before { sign_in user }

    context 'with valid params' do
      it 'shows message that password was changed' do
        post :change_password, params: valid_params
        expect(response).to redirect_to settings_edit_path(tab: 'privacy')
        expect(flash[:notice]).to eq I18n.t('settings.change_password.success')
      end
    end

    context 'with invalid params' do
      it 'shows fail message' do
        post :change_password, params: invalid_params
        expect(response).to redirect_to settings_edit_path(tab: 'privacy')
        expect(flash[:alert]).to eq I18n.t('settings.change_password.fail')
      end
    end
  end

  describe 'POST #update' do
    let(:user) { create(:user, billing_address: create(:billing_address)) }
    let(:billing_address) { build(:billing_address) }

    let(:valid_params) { { billing_address: billing_address.attributes.except('user_id', 'order_id') } }
    let(:invalid_params) { { billing_address: billing_address.attributes.except('city') } }

    before { sign_in user }

    context 'with valid params' do
      it 'changes an address' do
        expect do
          post :update, params: valid_params
        end.to(change { user.billing_address.reload.city }.to(billing_address.city))
      end
    end

    context 'with invalid params' do
      it 'does NOT change an address' do
        expect do
          post :update, params: invalid_params
        end.not_to(change { user.billing_address.reload.city })
      end
    end
  end
end
