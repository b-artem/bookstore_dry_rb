# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:valid_session) { {} }
  let(:make_request) { post :facebook, params: {}, session: valid_session }

  let(:omniauth_uid) { Faker::Lorem.characters(8) }
  let(:email) { Faker::Internet.email }
  let(:auth_hash) do
    OpenStruct.new(
      provider: 'facebook',
      uid: omniauth_uid,
      info: OpenStruct.new(
        email: email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    )
  end

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = auth_hash
  end

  describe 'POST #facebook' do
    context 'when user already exists' do
      before do
        create :user, omniauth_provider: 'facebook', omniauth_uid: omniauth_uid
      end

      it 'does NOT create a user' do
        expect { make_request }.not_to change(User, :count)
      end

      it 'redirects to home path' do
        make_request
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when user does NOT exist' do
      it 'creates a new user' do
        expect { make_request }.to change(User, :count).by 1

        user = User.last
        expect(user.omniauth_uid).to eq omniauth_uid
        expect(user.email).to eq email
      end

      it 'redirects to home path' do
        make_request
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
