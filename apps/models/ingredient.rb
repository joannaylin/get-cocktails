require 'pry'
class Ingredient < ActiveRecord::Base
  has_many :cocktail_ingredients
  has_many :cocktails, through: :cocktail_ingredients

  def self.internet_search_cocktails(ingredient)
    
    search_for_url = ingredient.gsub(' ', '_')
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{search_for_url}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    body = response.body
    cocktails = JSON.parse(body)

    drink_names = cocktails["drinks"].map do |drink|
      drink["strDrink"]
    end
    
    five_drinks = []
    5.times do 
      five_drinks << drink_names.sample
    end
    
    array = []
     five_drinks.each do |drink_name|
      drinks = Cocktail.internet_cocktails(drink_name).first
      array << drinks
    end
    array 
  end
 
  def print_cocktail_names
    self.cocktails.each_with_index { |cocktail, index| puts "#{index + 1}.#{cocktail.name}" }
  end


end