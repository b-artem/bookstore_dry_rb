require 'rails_helper'
require 'support/factory_girl'


shared_examples 'latest books' do
  background do
    5.times { create :book }
    visit home_index_path
  end

  scenario 'displays latest 3 books, added onto website' do
    latest = Book.order('created_at DESC').limit(3)
    within '.carousel-inner' do
      expect(page).to have_content(latest.first.title)
      expect(page).to have_content(latest.second.title)
      expect(page).to have_content(latest.third.description[0..20])
    end
  end

  scenario 'does not display latest 4th book, added onto website' do
    within '.carousel' do
      expect(page).not_to have_content(Book.order('created_at DESC')
                                            .fourth.title)
    end
  end

  scenario 'flips the slide' do
    latest = Book.order('created_at DESC').limit(2)
    within '.carousel-inner > .item.active' do
      expect(page).to have_content(latest.first.title)
    end
    page.find('a.right.carousel-control').click
    within '.carousel-inner > .item.active' do
      expect(page).to have_content(latest.last.title)
    end
  end
end

feature 'Home page' do
  feature 'latest books' do
    context 'when user is a guest' do
      it_behaves_like 'latest books'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      background { sign_in user }
      it_behaves_like 'latest books'
    end
  end
end
