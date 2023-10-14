require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { create(:user) }

  scenario 'User can view their profile and recipes' do
    visit user_path(user)
    expect(page).to have_content(user.name)

    user.recipes.each do |recipe|
      expect(page).to have_link(recipe.name)
      expect(page).to have_content(recipe.description)
    end

    expect(page).to have_link('Edit this user', href: edit_user_path(user))
    expect(page).to have_link('Back to users', href: users_path)
    expect(page).to have_button('Delete this user')
  end
end
