require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'home page' do
  background do
    5.times { create :book }
    allow(Book).to receive(:best_seller).and_return(Book.first)
    allow_any_instance_of(Book).to receive_message_chain(:images, :[], :image_url)
      .and_return("https://images-na.ssl-images-amazon.com/images/I/517JAFQLpdL.jpg")
    visit home_index_path
  end

  scenario 'shows Latest books block' do
    expect(page).to have_css('#slider.carousel.slide')
  end

  scenario 'shows Get started bock' do
    expect(page).to have_text('Welcome to our amazing Bookstore!')
    expect(page).to have_button('Get Started')
  end

  scenario 'shows Best sellers block' do
    expect(page).to have_text('Best Sellers')
  end
end

feature 'Home page' do
  context 'when user is a guest' do
    it_behaves_like 'home page'
  end

  context 'when user is logged in' do
    let(:user) { create(:user) }
    background { sign_in user }
    it_behaves_like 'home page'
  end
end
