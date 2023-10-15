require 'rails_helper'

RSpec.describe ShoppingListsController, type: :controller do
  describe 'GET #index' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
    let(:recipe) do
      Recipe.create(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, description: 'Test Description',
                    public: true, user_id: user.id)
    end
    let(:food) { Food.create(name: 'Test Food', measurement_unit: 'unit', price: 10, quantity: 10, user_id: user.id) }
    let(:recipe_food) { RecipeFood.create(quantity: 5, recipe_id: recipe.id, food_id: food.id) }

    before do
      sign_in user
    end

    it 'assigns the correct instance variables' do
      get :index, params: { user_id: user.id, recipe_id: recipe.id }
    end
  end
end
