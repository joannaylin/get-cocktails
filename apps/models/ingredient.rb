require 'pry'
class Ingredient < ActiveRecord::Base
  has_many :cocktail_ingredients
  has_many :cocktails, through: :cocktail_ingredients

  def self.multiple_search_cocktails(ingredient)
    search_for_url = ingredient.gsub(' ', '_')
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{search_for_url}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    body = response.body

    if body.length > 0
      cocktails = JSON.parse(body)
      drink_ids = cocktails["drinks"].map do |drink|
        drink["idDrink"]
      end
      
      spinner = TTY::Spinner.new("[:spinner] Loading ...")
      spinner.auto_spin

      array = []
      drink_ids.each do |drink_name|
        drinks = Ingredient.id_cocktails(drink_name).first
        array << drinks
      end

      spinner.stop("Done!")

      if array.length > 5
        ingredient_count = Hash.new(0)
        array.each do |cocktail|
          cocktail[:ingredients].each do |ingredient, measure|
            ingredient_count[ingredient] += 1
          end
        end

        ingredient_results = ingredient_count.sort_by{|ingredient, number| number}.reverse
        top_three = ingredient_results[1..3]
        options = top_three.map {|k,v| "#{k}- would return #{v} results" }
        space
        additional_ingredient = TTY::Prompt.new.select("Your search returned #{array.length} results! Narrow your search by adding another ingredient:", options)
        new_arr = array.select do |cocktail|
          cocktail[:ingredients].include? additional_ingredient.split("-")[0]
        end
        new_arr
      else
        array
      end
    end
  end
 
  def print_cocktail_names
    self.cocktails.each_with_index { |cocktail, index| puts "#{index + 1}.#{cocktail.name}" }
  end

  # search cocktail database by id to prevent errors with special characters in cocktail name 
  def self.id_cocktails(search_term)
    search_for_url = search_term.gsub(' ', '_')
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{search_for_url}"
    Cocktail.cocktail_search_helper(url)
  end
end
