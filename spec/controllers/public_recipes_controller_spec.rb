require 'rails_helper'

RSpec.describe PublicRecipesController, type: :controller do
  describe 'GET #index' do
    it 'assigns public recipes to @recipes' do
      user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password', confirmed_at: Time.now)
      public_recipe = Recipe.create(name: 'Public Recipe 1', public: true, user:)
      private_recipe = Recipe.create(name: 'Private Recipe', public: false, user:)

      get :index

      expect(assigns(:recipes)).to eq([public_recipe])
      expect(assigns(:recipes)).not_to include(private_recipe)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
