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

# Actual run file starts here

search
