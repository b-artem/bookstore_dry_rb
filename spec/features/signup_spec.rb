require 'rails_helper'
require 'support/factory_girl'

feature 'Signup' do
  let(:password) { Faker::Internet.password(8) }
  let(:book) { create :book }
  background do
    # stub_template "home/_best_sellers.html.erb" => "Here comes Best Sellers"
    allow(Book).to receive(:best_seller).and_return(book)
    visit new_user_registration_path
  end

  scenario 'User registers successfully via register form' do
    3.times { create :book }
    within 'form#new_user' do
      fill_in 'email', with: Faker::Internet.email
      fill_in 'password', with: password
      fill_in 'confirm-password', with: password
      click_button 'Sign Up'
    end
    expect(page).to have_text 'You have signed up successfully'
    expect(page).not_to have_content 'Enter Email'
    expect(page).not_to have_content 'Password'
    expect(page).not_to have_button 'Sign Up'
  end

  scenario 'User fails to register via register form' do
    within 'form#new_user' do
      fill_in 'email', with: Faker::Internet.email
      fill_in 'password', with: password
      fill_in 'confirm-password', with: (password + '1')
      click_button 'Sign Up'
    end
    expect(page).not_to have_text 'You have signed up successfully'
    expect(page).to have_content 'Enter Email'
    expect(page).to have_content 'Password'
    expect(page).to have_button 'Sign Up'
  end
end
