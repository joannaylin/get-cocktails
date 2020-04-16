class AddColumnMeasureToIngredients < ActiveRecord::Migration[6.0]

  def change
    add_column :ingredients, :measure, :string
  end

end