class RecipeFoodsController < ApplicationController
  def new
    @user = current_user
    @food_list = @user.foods
    @recipe = Recipe.find(params[:recipe_id])
    @foods = filter_foods(@recipe, @food_list)
    @new_recipe_food = RecipeFood.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    recipe_food = RecipeFood.new(recipe_food_params)
    if recipe_food.save
      redirect_to user_recipe_path(user_id: current_user.id, id: recipe_food.recipe_id)
    else
      render :new
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      flash[:success] = "Quantity updated successfully"
    else
      flash[:error] = "Failed to update quantity"
    end
    redirect_to user_recipe_path(current_user, @recipe_food.recipe)
  
  end

  def edit
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @foods = Food.all
  end

  def destroy
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to user_recipe_path(@user, @recipe), notice: 'Food removed from recipe.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end

  def filter_foods(recipe, foods)
    recipe_food_ids = RecipeFood.where(recipe_id: recipe.id).pluck(:food_id)

    foods.reject { |food| recipe_food_ids.include?(food.id) }
  end
end
