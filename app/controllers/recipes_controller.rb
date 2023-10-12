class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.all
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe created!'
      # redirect_to @recipe
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe updated!'
      redirect_to user_recipes_path(current_user, @recipe)
    else
      render 'edit'
    end
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :user_id)
  end
end