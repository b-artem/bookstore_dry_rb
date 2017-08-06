require 'rails_helper'
# require 'support/devise'
describe 'devise/sessions/new', type: :view do
  before do
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    allow(view).to receive(:resource).and_return(User.new)
    allow(view).to receive(:resource_name).and_return(:user)

    render
  end

  it 'has Facebook icon' do
    expect(rendered).to have_content 'i.fa.fa-facebook-official'
  end
end
