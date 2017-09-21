require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'cart' do
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
  end

  context 'when user clicks Cart icon in top right corner' do
    background { visit home_index_path }
    scenario 'Cart page opens' do
      click_link 'cart'
      expect(page).to have_text('Cart')
      expect(page).to have_text('Enter Your Coupon Code')
      expect(page).to have_button('Checkout')
    end
  end

  context 'when user wants to see Book details' do
    background do
      visit home_index_path
      create(:line_item, cart: Cart.last, book: book )
      visit cart_path(Cart.last)
    end

    context 'user clicks Photo' do
      scenario 'Book view page opens' do
        click_link "photo-view-#{book.id}"
        expect(current_path).to eq book_path(book)
        expect(page).to have_text(book.decorate.authors_names)
        expect(page).to have_text(book.publication_year)
      end
    end

    context 'user clicks Title' do
      scenario 'Book view page opens' do
        click_link "title-view-#{book.id}-xs"
        expect(current_path).to eq book_path(book)
        expect(page).to have_text(book.decorate.authors_names)
        expect(page).to have_text(book.publication_year)
      end
    end
  end
  #
  # scenario 'shows Get started bock' do
  #   expect(page).to have_text('Welcome to our amazing Bookstore!')
  #   expect(page).to have_button('Get Started')
  # end
  #
  # scenario 'shows Best sellers block' do
  #   expect(page).to have_text('Best Sellers')
  # end
end

feature 'Cart' do
  context 'when user is a guest' do
    it_behaves_like 'cart'
  end

  context 'when user is logged in' do
    let(:user) { create(:user) }
    background { sign_in user }
    it_behaves_like 'cart'
  end
end
