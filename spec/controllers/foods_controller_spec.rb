require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  before do
    allow_any_instance_of(User).to receive(:send_confirmation_instructions).and_return(nil)
    allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
  end

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
end
