require_relative '../config/environment'

# We will need a way to identify the user - can ask for their name?

puts "Let's search for a cocktail. Enter a cocktail you want to see:"
cocktail = gets.chomp
found_cocktail = Cocktail.where("name like ?", "#{cocktail}").first
ingredients = found_cocktail.ingredients

puts "We have found a matching cocktail!"
puts "Name: #{found_cocktail.name}"
puts "Ingredients: #{ingredients}"
