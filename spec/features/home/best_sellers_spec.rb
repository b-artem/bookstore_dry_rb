require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'best sellers' do
  let(:bestseller_mob_dev) { create :book_mobile_development }
  background do
    3.times { create :book_mobile_development }
    3.times { create :book_photo }
    3.times { create :book_web_design }
    3.times { create :book_web_development }
    # bestseller_photo = Book.photo.take
    # bestseller_web_design = Book.web_design.take
    # bestseller_web_dev = Book.web_development.take
    allow(Book).to receive("best_seller").and_return(bestseller_mob_dev)

      # allow(Book).to receive(:best_seller).with(:mobile_development)
      #   .and_return(bestseller_mob_dev)
      # allow(Book).to receive(:best_seller).with(:photo)
      #   .and_return(bestseller_photo)
      # allow(Book).to receive(:best_seller).with(:web_design)
      #   .and_return(bestseller_web_design)
      # allow(Book).to receive(:best_seller).with(:web_development)
      #   .and_return(bestseller_web_dev)
    visit home_index_path
  end

  # scenario 'displays latest 3 books, added onto website' do
  #   latest = Book.order('created_at DESC').limit(3)
  #   within '.carousel-inner' do
  #     expect(page).to have_content(latest.first.title)
  #     expect(page).to have_content(latest.second.title)
  #     expect(page).to have_content(latest.third.description[0..20])
  #   end
  # end
  #
  # scenario 'does not display latest 4th book, added onto website' do
  #   within '.carousel' do
  #     expect(page).not_to have_content(Book.order('created_at DESC')
  #                                           .fourth.title)
  #   end
  # end

  context 'when user clicks the View icon' do
    scenario 'details of item are shown' do
      # bestseller_mob_dev = Book.mobile_development.take
      # bestseller_photo = Book.photo.take
      # bestseller_web_design = Book.web_design.take
      # bestseller_web_dev = Book.web_development.take
      # allow(Book).to receive('best_seller(:mobile_developmet)' => bestseller_mob_dev)
      #   .and_return(bestseller_mob_dev)
      # allow(Book).to receive(:best_seller).with(:photo)
      #   .and_return(bestseller_photo)
      # allow(Book).to receive(:best_seller).with(:web_design)
      #   .and_return(bestseller_web_design)
      # allow(Book).to receive(:best_seller).with('web_development')
      #   .and_return(bestseller_web_dev)
      within('#bestsellers') { click_link("book-view-#{bestseller_mob_dev.id}",
                                      match: :first) }
      within "#book-#{bestseller_mob_dev.id}" do
        expect(page).to have_text(bestseller_mob_dev.title)
      end
    end
  end

  # context 'when user clicks Buy now button' do
  #   scenario 'adds chosen book to the cart', js: true do
  #     within '.carousel-inner > .item.active' do
  #       click_button('Buy Now')
  #     end
  #     wait_for_ajax
  #     expect(Cart.first.line_items.first.book).to eq Book.order('created_at DESC').first
  #   end
  # end
end

feature 'Home page' do
  feature 'best sellers' do
    context 'when user is a guest' do
      it_behaves_like 'best sellers'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      background { sign_in user }
      it_behaves_like 'best sellers'
    end
  end
end
