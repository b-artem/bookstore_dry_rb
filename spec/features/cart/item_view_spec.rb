# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'

RSpec.shared_examples 'item view' do
  let(:book) { create :book, :with_cover }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
  end

  context 'when user clicks Cart icon in top right corner' do
    background { visit home_index_path }
    scenario 'Cart page opens' do
      click_link 'cart'
      expect(page).to have_text(t('carts.show.cart'))
      expect(page).to have_text(t('carts.show.enter_coupon'))
      expect(page).to have_button(t('carts.show.checkout'))
    end
  end

  context 'when user wants to see Book details' do
    background do
      visit home_index_path
      create(:line_item, cart: Cart.last, book: book)
      visit cart_path(Cart.last)
    end

    context 'user clicks Photo' do
      scenario 'Book view page opens' do
        click_link "photo-view-#{book.id}"
        expect(page).to have_current_path book_path(book), ignore_query: true
        expect(page).to have_text(book.decorate.authors_names)
        expect(page).to have_text(book.publication_year)
      end
    end

    context 'user clicks Title' do
      scenario 'Book view page opens' do
        click_link "title-view-#{book.id}-xs"
        expect(page).to have_current_path book_path(book), ignore_query: true
        expect(page).to have_text(book.decorate.authors_names)
        expect(page).to have_text(book.publication_year)
      end
    end
  end
end

RSpec.feature 'Cart' do
  feature 'Item view' do
    context 'when user is a guest' do
      it_behaves_like 'item view'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }

      background { sign_in user }
      it_behaves_like 'item view'
    end
  end
end
