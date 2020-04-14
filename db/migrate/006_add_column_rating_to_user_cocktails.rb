class AddColumnRatingToUserCocktails < ActiveRecord::Migration[6.0]

  def change
    add_column :user_cocktails, :rating, :integer
  end

end