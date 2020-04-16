require_relative '../config/environment'

def space
  puts ""
  puts "- - - - - - - - - - - - -"
  puts ""
end

def welcome
  font = TTY::Font.new(:doom)
  puts font.write("The Cocktail App")
  puts "What is your name?"
  name = gets.chomp
  if User.where("name like ?", "%#{name}%").first
    user = User.where("name like ?", "%#{name}%").first
  else
    user = User.create(name: name)
  end
  puts "Welcome to the cocktail app, #{user.name}."
  user
end

def choice(user)
  puts <<-TEXT

  Please enter the number corresponding to what you want to do:
    
  1. Search cocktails by name

  2. Search cocktails by ingredient

  3. See your favorite cocktails

  4. Update a rating for one of your favorite cocktails

  5. Delete a cocktail from your favorites

  6. Exit the program

  ****** Enter your choice: ******
  TEXT
  input = gets.chomp
  puts ""
  case input.to_i
  when 1
    user.search_cocktails
    choice(user)
  when 2
    user.search_ingredients
    choice(user)
  when 3
    user.retrieve_user_favorites
    choice(user)
  when 4
    user.update_rating
    choice(user)
  when 5
    user.delete_favorite
    choice(user)
  when 6
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
