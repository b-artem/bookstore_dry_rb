require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'get started' do
  background do
    3.times { create :book_mobile_development }
    3.times { create :book_photo }
    3.times { create :book_web_design }
    3.times { create :book_web_development }
    visit home_index_path
  end

  context 'when user clicks Get started button' do
    scenario 'shows Catalog page, all filter by default', js: true do
      within '.jumbotron' do
        click_button('Get Started')
      end
      expect(page).to have_text(Book.mobile_development.first.title)
      expect(page).to have_text(Book.photo.first.title)
      expect(page).to have_text(Book.web_design.first.title)
      expect(page).to have_text(Book.web_development.first.title)
    end
  end
end

feature 'Home page' do
  feature 'Get started' do
    context 'when user is a guest' do
      it_behaves_like 'get started'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      background { sign_in user }
      it_behaves_like 'get started'
    end
  end
end
