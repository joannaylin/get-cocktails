class CreateCocktailsTable < ActiveRecord::Migration[5.0]

  def change
    create_table :cocktails do |t|
      t.string :name
    end
  end

end