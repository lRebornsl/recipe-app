class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def index
    @user = User.all
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe created!'
      redirect_back(fallback_location: user_recipes_path(current_user, @recipe))
    else
      render 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe updated!'
      redirect_back(fallback_location: user_recipes_path(current_user, @recipe))
    else
      render 'edit'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    if @recipe.destroy
      flash[:success] = 'Recipe deleted!'
    else
      flash[:error] = 'Failed to delete recipe.'
    end
    redirect_to user_recipes_path(current_user)
  end

  def toggle_privacy
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public) # Cambiar la privacidad
    redirect_to user_recipe_path(current_user, @recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :public, :user_id, :preparation_time, :cooking_time)
  end
end
