class FoodsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @foods = Food.where(user_id: @user.id)
  end

  def new
    @food = Food.new
    @user = current_user
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      # Create a recipe_food record to associate this food with the recipe
      recipe = Recipe.find(params[:recipe_id])
      recipe_food = RecipeFood.new(recipe:, food: @food)
      recipe_food.save

      redirect_to user_recipe_path(current_user, recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find_by(user_id: params[:user_id], id: params[:id])
    @recipe_food = RecipeFood.find_by(food_id: @food.id)
    @recipe_food&.destroy
    @food&.destroy

    redirect_to user_foods_path(current_user)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
