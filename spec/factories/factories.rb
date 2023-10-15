FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'user@example.com' }
    password { 'password123' }
  end

  factory :recipe do
    name { 'Delicious Recipe' }
    preparation_time { 30 }
    cooking_time { 60 }
    description { 'A tasty recipe example.' }
    public { true }

    association :user, factory: :user
  end

  factory :recipe_food do
    quantity { 1 }
    association :food, factory: :food
  end

  factory :food do
    name { 'Sample Food' }
    measurement_unit { 'g' }
    price { 5.0 }
  end
end