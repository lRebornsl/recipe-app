require 'rails_helper'


RSpec.describe 'recipes/show.html.erb', type: :view do
  describe 'integration tests for recipes page' do
    before(:each) do
      user = User.create(id: 1, name: 'Nico', email: 'nicobolanez@gmail.com', password: '123456')
      @recipe = Recipe.create(name: 'Burger', preparation_time: 34, cooking_time: 45, description: 'Test recipe 1', public: true, user: user)

      allow(view).to receive(:current_user).and_return(user)
      allow(view).to receive(:user_signed_in?).and_return(true)

      assign(:recipe, @recipe)
      render
    end

    scenario 'displays recipe details' do
      expect(rendered).to have_content("Burger")
      expect(rendered).to have_content("Preparation Time (minutes):")
      expect(rendered).to have_content("Cooking Time (minutes):")
      expect(rendered).to have_content("Recipe Description:")
    end
  end
end
