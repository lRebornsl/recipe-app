require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    food = Food.new(name: 'Test Food', measurement_unit: 'grams', price: 10.99, quantity: 100, user_id: user.id)
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(measurement_unit: 'grams', price: 10.99, quantity: 100)
    expect(food).to_not be_valid
  end
end
