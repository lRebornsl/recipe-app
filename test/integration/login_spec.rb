require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user, email: 'user@example.com', password: 'password123') }

  scenario 'User can log in with valid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Log in')
  end

  scenario 'User can log out' do
    user = create(:user)
    sign_in user

    visit authenticated_root_path

    expect(page).to have_content('Forgot your password?')
  end
end
