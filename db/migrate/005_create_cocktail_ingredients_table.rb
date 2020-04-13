class CreateCocktailIngredientsTable < ActiveRecord::Migration[5.0]

  def change
    create_table :cocktail_ingredients do |t|
      t.integer :cocktail_id 
      t.integer :ingredient_id
    end
  end

end