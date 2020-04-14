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

def find_user
  puts "What is your name?"
  name = gets.chomp
  user = User.where("name like ?", "%#{name}%").first
end

def retrieve_user_favorites
  user = find_user

  puts "Your saved cocktails are:"
  user.print_saved_cocktails
end

def add_new_favorite
user = find_user

puts "Enter the name of the cocktail you want to add:"
cocktail = gets.chomp
found_cocktail = Cocktail.search_cocktails(cocktail)

  if user.cocktails.include? found_cocktail.first
    puts "This cocktail is already in your favorites. Your saved cocktails are:"
    user.print_saved_cocktails

  else
    user.cocktails << found_cocktail.first
    puts "#{found_cocktail.first.name} added to your favorites. Your saved cocktails are now:"
    user.print_saved_cocktails
  end
end


# Actual run file starts here

# retrieve_user_favorites
# add_new_favorite
# search
