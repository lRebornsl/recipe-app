class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, foreign_key: 'food_id'
  has_many :recipes, through: :recipe_foods
end
