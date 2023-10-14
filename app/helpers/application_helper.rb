module ApplicationHelper
  def calculate_total_price(recipe)
    total_price = 0
    recipe.foods.each do |food|
      total_price += food.price * food.quantity
    end
    number_to_currency(total_price)
  end
end
