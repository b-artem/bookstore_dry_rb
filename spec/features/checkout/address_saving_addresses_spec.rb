require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/wait_for_ajax'

shared_examples 'billing address is saved' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'billing address is saved from a form fields', js: true do
    address_fields.each do |field|
      expect(Order.find(order.id).billing_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'shipping address is saved' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'shipping address is saved from a form fields', js: true do
    address_fields.each do |field|
      expect(Order.find(order.id).shipping_address.public_send(field))
        .to eq shipping_address.public_send(field)
    end
  end
end

shared_examples 'billing address is used as shipping' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'Billing Address is used as Shipping Address', js: true do
    address_fields.each do |field|
      expect(Order.find(order.id).shipping_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'addresses was not saved' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'Address was NOT saved and form is rendered again', js: true do
    expect(Order.find(order.id).billing_address).to be_nil
    expect(Order.find(order.id).shipping_address).to be_nil
  end
end

shared_examples 'proceeds to next step' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'next step (Delivery) is rendered', js: true do
    expect(page).to have_content(t('orders.checkout.delivery.shipping_method'))
    expect(page).to have_content(t('orders.checkout.delivery.days'))
    expect(page).to have_content(t('orders.checkout.delivery.price'))
  end
end

shared_examples 'renders address form again' do
  background do
    click_button t('orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'next step (Delivery) is rendered', js: true do
    expect(page).to have_content(t('orders.checkout.address.billing_address'))
    expect(page).to have_content(t('orders.checkout.address.shipping_address'))
    expect(page).to have_content(t('orders.checkout.address.all_fields_are_required'))
  end
end

feature 'Checkout Address step' do
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
      it_behaves_like 'billing address is saved'
      it_behaves_like 'billing address is used as shipping'
      it_behaves_like 'proceeds to next step'
    end

    context 'when Use Billing Address checkbox is NOT selected' do
      background { fill_shipping_address(shipping_address) }
      it_behaves_like 'billing address is saved'
      it_behaves_like 'shipping address is saved'
      it_behaves_like 'proceeds to next step'
    end
  end

  context 'when not all required fields are filled correctly' do
    background { fill_billing_address(billing_address) }

    context 'when Use Billing Address checkbox is selected' do
      background do
        within '#billing-address-form' do
          field = %w[first_name last_name address city zip phone].sample
          fill_in(t("simple_form.labels.defaults.#{field}"), with: '')
        end
        find('label.checkbox-label').click
      end
      it_behaves_like 'addresses was not saved'
      it_behaves_like 'renders address form again'
    end

    context 'when Use Billing Address checkbox is not selected' do
      background do
        fill_shipping_address(shipping_address)
        within '#shipping-address-form' do
          field = %w[first_name last_name address city zip phone].sample
          fill_in(t("simple_form.labels.defaults.#{field}"), with: '')
        end
      end
      it_behaves_like 'addresses was not saved'
      it_behaves_like 'renders address form again'
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
          select(address.decorate.public_send(field),
                 from: t("simple_form.labels.defaults.#{field}"))
          next
        end
        fill_in(t("simple_form.labels.defaults.#{field}"),
                with: address.public_send(field))
      end
    end
end
