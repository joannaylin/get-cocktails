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



# App starts



def welcome
  puts "What is your name?"
  name = gets.chomp
  if User.where("name like ?", "%#{name}%").first
    user = User.where("name like ?", "%#{name}%").first
  else
    user = User.create(name: name)
  end
  puts "Welcome to the cocktail app, #{user.name}. Type the number corresponding to what you want to do:"
  user
end

def choice(user)
  puts <<-TEXT
  Please enter the number corresponding to what you want to do:
  1. Search cocktails by name
  2. Search cocktails by ingredient
  3. See your favorite cocktails
  4. Add a new cocktail to your favorites
  5. Update a rating for one of your favorite cocktails
  6. Delete a cocktail from your favorites
  7. Exit the program
  ****** Enter your choice: ******
  TEXT
  input = gets.chomp
  case input.to_i
  when 1
    search
    choice(user)
  when 2
    search_ingredients
    choice(user)
  when 3
    user.retrieve_user_favorites
    choice(user)
  when 4 
    user.add_new_favorite
    choice(user)
  when 5
    update_rating # Put this into users please :)
  when 6
    user.delete_favorite
    choice(user)
  when 7
    user.leave
  else
    "Sorry, I don't recognise that option."
    choice(user)
  end
end

def run
user = welcome
choice(user)
end

run

# Actual run file starts here
# user = find_user
# user.retrieve_user_favorites
# user.add_new_favorite
# user.delete_favorite
