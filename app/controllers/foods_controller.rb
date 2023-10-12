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
    @user = current_user
    @food.user_id = @user.id

    if @food.save
      redirect_to user_foods_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find_by(user_id: params[:user_id], id: params[:id])
    @food&.destroy

    redirect_to user_foods_path(current_user)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
