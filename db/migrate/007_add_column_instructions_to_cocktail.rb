class AddColumnInstructionsToCocktail < ActiveRecord::Migration[6.0]

  def change
    add_column :cocktails, :instructions, :string
  end

end