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

  def self.multiple_search_cocktails(ingredient)
    
    search_for_url = ingredient.gsub(' ', '_')
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{search_for_url}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    body = response.body
    cocktails = JSON.parse(body)

    drink_names = cocktails["drinks"].map do |drink|
      drink["strDrink"]
    end
    
    array = []
     drink_names.each do |drink_name|
      drinks = Cocktail.internet_cocktails(drink_name).first
      array << drinks
    end

    ingredient_count = Hash.new(0)
    array.each do |cocktail|
      cocktail[:ingredients].each do |ingredient|
        ingredient_count[ingredient] += 1
      end
    end
    option_one = ingredient_count.sort_by{|ingredient, number| number}.reverse[1]
    option_two = ingredient_count.sort_by{|ingredient, number| number}.reverse[2]
    option_three = ingredient_count.sort_by{|ingredient, number| number}.reverse[3]
    puts ""
    puts "- - - - - - - - - - - - -"
    puts ""
    puts "Your search returned #{array.length} results! Why not add another ingredient?"
    puts "**********"
    puts "#{option_one[0]} would return #{option_one[1]} results"
    puts "**********"
    puts "#{option_two[0]} would return #{option_two[1]} results"
    puts "**********"
    puts "#{option_three[0]} would return #{option_three[1]} results"
    puts ""
    puts "- - - - - - - - - - - - -"
    puts ""
    puts "********** Enter additional search term: **********"
    puts ""
    puts "- - - - - - - - - - - - -"
    puts ""
    additional_ingredient = STDIN.gets.chomp
    new_arr = array.select do |cocktail|
      cocktail[:ingredients].include? additional_ingredient
    end
    new_arr
  end
 
  def print_cocktail_names
    self.cocktails.each_with_index { |cocktail, index| puts "#{index + 1}.#{cocktail.name}" }
  end


end