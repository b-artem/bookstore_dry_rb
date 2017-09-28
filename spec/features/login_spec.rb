require 'rails_helper'
require 'support/factory_girl'

feature 'Login' do
  let(:user) { create :user }
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://images-na.ssl-images-amazon.com/images/I/517JAFQLpdL.jpg")
    visit new_user_session_path
  end

  context 'when email and password are valid' do
    background do
      3.times { create :book }
    end
    scenario 'logs user in' do
      within 'form#new_user' do
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'Log in'
      end
      expect(page).to have_text 'Signed in successfully'
      expect(page).not_to have_content 'Enter Email'
      expect(page).not_to have_content 'Password'
      expect(page).not_to have_button 'Log in'
    end
  end

  context 'when password is invalid' do
    scenario "doesn't log user in" do
      within 'form#new_user' do
        fill_in 'email', with: user.email
        fill_in 'password', with: (user.password + '1')
        click_button 'Log in'
      end
      expect(page).to have_text 'Invalid Email or password'
      expect(page).not_to have_text 'Signed in successfully'
      expect(page).to have_content 'Enter Email'
      expect(page).to have_content 'Password'
      expect(page).to have_button 'Log in'
    end
  end
end
