require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let(:user) { create(:user, email: 'user@example.com', password: 'password123') }

  scenario 'User can log in with valid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  scenario 'User cannot log in with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'invalid_password'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end
end
