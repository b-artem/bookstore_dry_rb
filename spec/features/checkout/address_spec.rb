# require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'

feature 'Checkout Address step' do
  let!(:user) { create :user }
  let!(:order) { create :order, user: user }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit order_checkout_index_path(order)
  end

  scenario 'has form for Billing and Shipping addresses' do
    expect(page).to have_content t('orders.checkout.steps.checkout')
    expect(page).to have_content t('orders.checkout.address.billing_address')
    expect(page).to have_content t('orders.checkout.address.shipping_address')
  end
end
