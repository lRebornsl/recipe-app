module ApplicationHelper
  def calculate_total_price(recipe)
    total_price = 0
    recipe.recipe_foods.each do |recipe_food|
      food = recipe_food.food
      total_price += food.price * recipe_food.quantity
    end
    number_to_currency(total_price)
  end
end
