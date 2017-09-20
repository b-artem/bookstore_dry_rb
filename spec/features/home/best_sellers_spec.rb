require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'best sellers' do
  let(:bestseller_mob_dev) { create :book_mobile_development }
  let(:bestseller_photo) { create :book_photo }
  let(:bestseller_web_design) { create :book_web_design }
  let(:bestseller_web_dev) { create :book_web_development }

  background do
    create(:order, state: 'delivered', line_items: [
            create(:line_item, book: bestseller_mob_dev),
            create(:line_item, book: bestseller_photo),
            create(:line_item, book: bestseller_web_design),
            create(:line_item, book: bestseller_web_dev) ])
    3.times do
      create :book_mobile_development
      create :book_photo
      create :book_web_design
      create :book_web_development
    end
    visit home_index_path
  end

  scenario 'shows best sellers from each category' do
    within('#bestsellers') do
      expect(page).to have_text(bestseller_mob_dev.title)
      expect(page).to have_text(bestseller_photo.price)
      expect(page).to have_text(bestseller_web_design.title)
      expect(page).to have_text(bestseller_web_dev.price)
    end
  end

  context 'when user clicks the View icon' do
    scenario 'details of item are shown' do
      within '#bestsellers' do
        click_link("book-view-#{bestseller_mob_dev.id}")
      end
      within "#book-#{bestseller_mob_dev.id}" do
        expect(page).to have_text(bestseller_mob_dev.title)
      end
    end
  end

  # context 'when user clicks Cart icon' do
  #   scenario 'adds chosen book to the cart', js: true do
  #     within '#bestsellers' do
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
