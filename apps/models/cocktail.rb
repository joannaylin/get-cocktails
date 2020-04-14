class Cocktail < ActiveRecord::Base
  has_many :cocktail_ingredients
  has_many :ingredients, through: :cocktail_ingredients
  has_many :user_cocktails
  has_many :users, through: :user_cocktails

  # List all the cocktails stored within the app
  def self.retrieve_cocktail_names
    self.all.map { |cocktail| puts cocktail.name }
  end

  def self.search_cocktails(search_term)
    cocktails = Cocktail.where("name like ?", "%#{search_term}%")
  end

  def print_ingredient_names
    self.ingredients.map { |ingredient| ingredient.name }
  end

end