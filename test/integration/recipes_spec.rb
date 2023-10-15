require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :view do
  describe 'integration tests for recipes page' do
    before(:each) do
      user = User.create(id: 1, name: 'Nico', email: 'nicobolanez@gmail.com', password: '123456')
      @user = user

      recipe1 = Recipe.create(name: 'Burger', preparation_time: 34, cooking_time: 45, description: 'Test recipe 1',
                              public: true, user:)
      recipe2 = Recipe.create(name: 'Pizza', preparation_time: 25, cooking_time: 30, description: 'Test recipe 2',
                              public: true, user:)

      @recipes = [recipe1, recipe2]

      allow(view).to receive(:current_user).and_return(user)
      allow(view).to receive(:user_signed_in?).and_return(true)

      render
    end

    scenario 'displays recipe details' do
      expect(rendered).to have_content('My Recipes')
      expect(rendered).to have_content('remove')
    end
  end
end
