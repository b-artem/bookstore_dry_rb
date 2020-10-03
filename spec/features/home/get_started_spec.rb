# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

RSpec.shared_examples 'get started' do
  background do
    create :book_mobile_development, :with_cover
    create :book_photo, :with_cover
    create :book_web_design, :with_cover
    create :book_web_development, :with_cover
    visit home_index_path
  end

  context 'when user clicks Get started button' do
    scenario 'shows Catalog page, all filter by default', js: true do
      within '.jumbotron' do
        click_button(I18n.t('home.index.get_started'))
      end
      Book.all.each do |book|
        expect(page).to have_text(book.title)
      end
    end
  end
end

RSpec.feature 'Home page' do
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
