require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'

feature 'Checkout Address saves addresses from forms' do
  let!(:user) { create :user }
  let!(:order) { create :order, user: user }
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit order_checkout_index_path(order)
  end



end
