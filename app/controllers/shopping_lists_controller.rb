class ShoppingListsController < ApplicationController
  def index
    @foods = Food.where(user_id: current_user.id)
    @recipe_foods = RecipeFood.joins(recipe: :user).where(users: { id: current_user.id })
    @food_quantities = @recipe_foods.group_by(&:food_id).transform_values { |foods| foods.sum(&:quantity) }
    @greater_quantities = {}
    total_price = 0
    @food_quantities.each do |food_id, quantity|
      food = Food.find_by(id: food_id)

      next unless food && quantity > food.quantity

      difference = quantity - food.quantity

      @greater_quantities[food_id] = {
        name: food.name,
        quantity: difference,
        measurement_unit: food.measurement_unit,
        price: food.price * difference
      }
      total_price += @greater_quantities[food_id][:price]
    end
    @greater_quantities_array = @greater_quantities.to_a
    @total_foods = @greater_quantities.size
    @total_price = total_price
  end
end
