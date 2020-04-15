class Cocktail < ActiveRecord::Base
  has_many :cocktail_ingredients
  has_many :ingredients, through: :cocktail_ingredients
  has_many :user_cocktails
  has_many :users, through: :user_cocktails

  # List all the cocktails stored within the app
  def self.retrieve_cocktail_names
    self.all.map { |cocktail| cocktail.name }
  end

  # def self.search_cocktails(search_term)
  #   cocktails = Cocktail.where("name like ?", "%#{search_term}%")
  # end

  def self.internet_cocktails(search_term)
  
    search_for_url = search_term.gsub(' ', '_')

    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{search_for_url}"

    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)

    body = response.body

    cocktails = JSON.parse(body)
    if cocktails["drinks"]
      cocktail_names = cocktails["drinks"].map do |cocktail_info|
        my_name = cocktail_info["strDrink"]
      end
      # cocktail_hash = { name: my_name }
      # Cocktail.new(cocktail_hash)
    end
  end
    
    # Cocktail.all.map { |cocktail| puts cocktail.name }

  def print_ingredient_names
    self.ingredients.map { |ingredient| ingredient.name }
  end




end