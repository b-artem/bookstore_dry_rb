# frozen_string_literal: true

require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/dry_validation/payment_info'

RSpec.shared_examples 'checkout address page opens' do
  scenario 'Checkout Address page opens' do
    expect(page).to have_content(t('orders.checkout.address.shipping_address'))
    expect(page).to have_content(t('orders.checkout.address.all_fields_are_required'))
    expect(page).to have_content(t('orders.checkout.address.use_billing_address'))
    expect(page).not_to have_button(t('orders.checkout.confirm.place_order'))
  end
end

RSpec.shared_examples 'than returns to confirm page' do
  context 'when user than clicks Save and Continue button' do
    background { click_button(t('orders.checkout.save_and_continue')) }
    scenario 'returns to Checkout Confirm page' do
      expect(page).to have_content(t('orders.checkout.confirm.edit'))
      expect(page).to have_content(t('orders.checkout.confirm.shipments'))
      expect(page).to have_content(t('orders.checkout.confirm.payment_information'))
      expect(page).to have_button(t('orders.checkout.confirm.place_order'))
      within '#total' do
        expect(page).to have_content(order.decorate.total)
      end
    end
  end
end

RSpec.feature 'Checkout Payment step' do
  let!(:user) { create :user }
  let(:payment_fields) { %i[card_number name_on_card valid_until cvv] }
  let(:payment_information) { payment_info }
  let(:billing_address) { build :billing_address }
  let(:shipping_address) { build :shipping_address }
  let(:shipping_method) { create :shipping_method }
  let(:books) { create_list(:book, 2, :with_cover) }
  let(:line_items) do
    [create(:line_item, book: books[0]), create(:line_item, book: books[1])]
  end
  let!(:order) do
    create(:order, user: user, line_items: line_items,
                   billing_address: billing_address, shipping_address: shipping_address,
                   shipping_method: shipping_method)
  end

  include_context 'payment info'

  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    payment_fields.each do |field|
      page.set_rack_session(field => payment_information[field])
    end
    visit(order_checkout_index_path(order) + '/confirm')
  end

  context 'when user wants to edit some information' do
    context 'when user clicks Edit Shipping Address link' do
      background do
        within '#shipping-address' do
          click_link(t('orders.checkout.confirm.edit'))
        end
      end
      include_examples 'checkout address page opens'
      include_examples 'than returns to confirm page'
    end

    context 'when user clicks Edit Billing Address link' do
      background do
        within '#billing-address' do
          click_link(t('orders.checkout.confirm.edit'))
        end
      end
      include_examples 'checkout address page opens'
      include_examples 'than returns to confirm page'
    end

    context 'when user clicks Edit Shipment link' do
      background do
        within '#shipment' do
          click_link(t('orders.checkout.confirm.edit'))
        end
      end

      scenario 'Checkout Delivery page opens' do
        expect(page).to have_content(t('orders.checkout.delivery.method'))
        expect(page).to have_content(t('orders.checkout.delivery.days'))
        expect(page).to have_content(t('orders.checkout.delivery.price'))
        expect(page).not_to have_button(t('orders.checkout.confirm.place_order'))
      end

      include_examples 'than returns to confirm page'
    end

    context 'when user clicks Edit Payment information link' do
      background do
        within '#payment' do
          click_link(t('orders.checkout.confirm.edit'))
        end
      end

      scenario 'Checkout Payment page opens' do
        expect(page).to have_content(t('orders.checkout.payment.name_on_card'))
        expect(page).to have_content(t('orders.checkout.payment.card_number'))
        expect(page).to have_content(t('orders.checkout.payment.cvv'))
        expect(page).not_to have_button(t('orders.checkout.confirm.place_order'))
      end

      include_examples 'than returns to confirm page'
    end
  end

  context 'when user clicks Place Order button' do
    background { click_button t('orders.checkout.confirm.place_order') }
    scenario 'Checkout Complete page opens' do
      expect(page).to have_content(t('orders.checkout.complete.thank_you_for_your_order'))
      expect(page).to have_content(t('orders.checkout.complete.order_confirmation_has_been_sent'))
      expect(page).to have_button(t('orders.checkout.complete.back_to_store'))
    end
  end
end
