require_relative '../config/environment'

def search
  puts "Let's search for a cocktail. Enter a cocktail you want to see:"
  cocktail = gets.chomp
  found_cocktail = Cocktail.search_cocktails(cocktail)

  if found_cocktail.length == 1
      puts "We have found one cocktail that matches your search!"
      puts "Name: #{found_cocktail.first.name}"
      puts "Ingredients: #{found_cocktail.first.print_ingredient_names.join(", ")}"
  elsif found_cocktail.length > 1
      puts "We have found #{found_cocktail.length} cocktails that match your search!"
      # Not sure how we list them. Need a way to print them out. Not really an issue until the API comes in
  else
    puts "Sorry, that search term doesn't match anything in the database."
  end
end

def search_ingredients
  puts "Let's search for cocktails with the ingredient you had in mind. Enter your ingredient:"
  ingredient = gets.chomp
  found_ingredient = Ingredient.search_cocktails(ingredient)

  if found_ingredient
    puts "The following drinks contain ingredient, #{ingredient}:"
    found_ingredient.first.print_cocktail_names
  else
    puts "Sorry, that ingredient could not be found."
  end

end

def update_rating
  puts "Let's update the rating for one of your favorite drinks! Enter the drink you want to update:"
  cocktail = gets.chomp
  found_cocktail = Cocktail.search_cocktails(cocktail)

  if found_cocktail 
    puts "What rating would you give #{found_cocktail.first.name} on a scale of 1-10? 1 being the worst, and 10 being the best."
    updated_rating = gets.chomp
    found_cocktail.first.user_cocktails.update(rating: updated_rating)
  else
    puts "Sorry, that drink could not be found in your favorites list."
  end
end


# Actual run file starts here

# search
# search_ingredients
# update_rating
