class CreateUserCocktailsTable < ActiveRecord::Migration[5.0]

  def change
    create_table :user_cocktails do |t|
      t.integer :user_id
      t.integer :cocktail_id
    end
  end

end