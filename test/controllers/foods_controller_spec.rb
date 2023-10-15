require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      Food.create(name: 'Test Food', measurement_unit: 'grams', price: 10.99, quantity: 100, user_id: user.id)
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      sign_in user
      get :new, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new food' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      sign_in user
      expect do
        post :create,
             params: { user_id: user.id,
                       food: { name: 'New Food', measurement_unit: 'grams', price: 9.99, quantity: 200 } }
      end.to change(Food, :count).by(1)
    end

    it "redirects to the user's foods path after creation" do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      sign_in user
      post :create,
           params: { user_id: user.id,
                     food: { name: 'New Food', measurement_unit: 'grams', price: 9.99, quantity: 200 } }
      expect(response).to redirect_to(user_foods_path(user))
    end

    # Add more tests for invalid parameters if needed
  end
end
