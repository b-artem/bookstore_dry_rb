require 'rails_helper'
require 'support/factory_girl'

feature 'Signup' do
  let(:password) { Faker::Internet.password(8) }
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://images-na.ssl-images-amazon.com/images/I/517JAFQLpdL.jpg")
    visit new_user_registration_path
  end

  context 'when password confirmation valid' do
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
  end

  context 'when password confirmation invalid' do
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
end
