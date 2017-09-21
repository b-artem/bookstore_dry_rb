require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'
# require 'support/wait_for_ajax'

shared_examples 'edit' do
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
    visit home_index_path
  end

  # context 'when user clicks Cart icon in top right corner' do
  #   background { visit home_index_path }
  #   scenario 'Cart page opens' do
  #     click_link 'cart'
  #     expect(page).to have_text('Cart')
  #     expect(page).to have_text('Enter Your Coupon Code')
  #     expect(page).to have_button('Checkout')
  #   end
  # end

  context 'when user wants to edit Cart' do
    let!(:line_item) { create(:line_item, cart: Cart.last, book: book) }
    background do
      visit cart_path(Cart.last)
    end

    context 'when product quantity = 1', js: true do
      context "user clicks '+' button" do
        scenario 'increments quantity' do
          within "#line-item-#{line_item.id}" do
            expect(LineItem.last.quantity).to eq 1
            expect(page.find_by_id("input-line-item-#{line_item.id}").value)
              .to eq '1'
            click_link("plus-#{line_item.id}")
            # wait_for_ajax does NOT help
            sleep 0.1
            expect(LineItem.last.quantity).to eq 2
            expect(page.find_by_id("input-line-item-#{line_item.id}").value)
              .to eq '2'
          end
        end
      end
    end

    context 'when product quantity = 2' do

    end
    #
    # context 'user clicks Title' do
    #   scenario 'Book view page opens' do
    #     click_link "title-view-#{book.id}-xs"
    #     expect(current_path).to eq books_path(book).gsub('.', '/')
    #     expect(page).to have_text(book.decorate.authors_names)
    #     expect(page).to have_text(book.publication_year)
    #   end
    # end
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
  feature 'Edit' do
    context 'when user is a guest' do
      it_behaves_like 'edit'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      background { sign_in user }
      it_behaves_like 'edit'
    end
  end
end
