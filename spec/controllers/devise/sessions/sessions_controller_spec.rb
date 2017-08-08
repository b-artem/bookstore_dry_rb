require 'support/devise'
require 'support/factory_girl'

describe Devise::SessionsController, type: :controller do
  let(:user) { create :user }

  before do
    # allow(User).to receive(:new).and_return(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :new
    # get :new, params: {}, session: valid_session
  end

  describe 'GET #new' do
    context 'when password is valid' do
      before { login_as(user, :scope => :user) }

      it "returns a success response" do
        expect(response).to be_success
      end

      it { is_expected.to redirect_to root_url }
    end
  end
end
