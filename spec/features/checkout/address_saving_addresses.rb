require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/wait_for_ajax'

shared_examples 'Billing Address is saved' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'Billing Address is saved from a form fields', js: true do
    address_fields.each do |field|
      next if field == 'country'
      expect(order.billing_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'Shipping Address is saved' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'Shipping Address is saved from a form fields', js: true do
    address_fields.each do |field|
      next if field == 'country'
      expect(order.shipping_address.public_send(field))
        .to eq shipping_address.public_send(field)
    end
  end
end

shared_examples 'Billing Address is used as Shipping' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'Billing Address is saved and used for Shipping Address', js: true do
    binding.pry
    address_fields.each do |field|
      next if field == 'country'
      expect(order.shipping_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'proceeds to Shipping step' do

end

feature 'Checkout Address saves addresses from forms' do
  let!(:user) { create :user }
  let!(:order) { create :order, user: user }
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  let(:billing_address) { build :billing_address }
  let(:shipping_address) { build :shipping_address }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    create :shipping_method
    visit order_checkout_index_path(order)
  end

  context 'when all required fields are filled correctly' do
    background { fill_billing_address(billing_address) }

    context 'when Use Billing Address checkbox is selected' do
      background { find('label.checkbox-label').click }
      it_behaves_like 'Billing Address is saved'
      it_behaves_like 'Billing Address is used as Shipping'
    end

    context 'when Use Billing Address checkbox is NOT selected' do
      background { fill_shipping_address(shipping_address) }
      it_behaves_like 'Billing Address is saved'
      it_behaves_like 'Shipping Address is saved'
    end
  end

  context 'when not all required fields are filled correctly' do
    context 'when Use Billing Address checkbox is selected' do

    end

    context 'when Use Billing Address checkbox is not selected' do

    end
  end

  private

    def fill_billing_address(address)
      within '#billing-address-form' do
        fill_address(address)
      end
    end

    def fill_shipping_address(address)
      within '#shipping-address-form' do
        fill_address(address)
      end
    end

    def fill_address(address)
      address_fields.each do |field|
        if field == 'country'
          select(address.public_send(field), from: t("simple_form.labels.defaults.#{field}"))
          next
        end
        fill_in(t("simple_form.labels.defaults.#{field}"),
                with: address.public_send(field))
      end
    end
end
