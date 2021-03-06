class Cocktail < ActiveRecord::Base
  has_many :cocktail_ingredients
  has_many :ingredients, through: :cocktail_ingredients
  has_many :user_cocktails
  has_many :users, through: :user_cocktails

  def self.search_cocktails(search_term)
    cocktails = Cocktail.where("name like ?", "%#{search_term}%")
  end

  def self.internet_cocktails(search_term)
    search_for_url = search_term.gsub(' ', '_')
    url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{search_for_url}"
    self.cocktail_search_helper(url)
  end

  def print_ingredient_names
    self.ingredients.map { |ingredient| ingredient.name }
  end

  def self.cocktail_search_helper(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    body = response.body
    cocktails = JSON.parse(body)
    
    array = []
    if cocktails["drinks"]
      cocktails["drinks"].each do |drink|
        hash = {}
        drink_name = drink["strDrink"]
        drink_instructions = drink["strInstructions"]
        drink_ingredients = {}
        ingredient_string = "strIngredient1"
        measure_string = "strMeasure1"
        i = 1
          while drink[ingredient_string]
            ingredient = drink[ingredient_string]
            drink_ingredients[ingredient] = drink[measure_string]
            i += 1
            ingredient_string = "strIngredient" + i.to_s
            measure_string = "strMeasure" + i.to_s
          end
        hash[:name] = drink_name
        hash[:ingredients] = drink_ingredients
        hash[:instructions] = drink_instructions
        array << hash
      end
      array
    end
  end

end