class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

  def search_cocktails
    puts "Let's search for a cocktail. Enter a cocktail you want to see:"
    cocktail = gets.chomp
    found_cocktail_list = Cocktail.internet_cocktails(cocktail)
  
    if found_cocktail_list
      found_cocktail_list.each do |name, ingredients|
        puts "name: #{name}"
        puts "ingredients: #{ingredients.join(", ")}"
      end
    else
      puts "Sorry, that search term doesn't match anything in the database."
    end
    puts "Type in the name of the cocktail you want to save into your favorites:"
    cocktail = gets.chomp
    if found_cocktail_list.include? cocktail
      drink = Cocktail.create(name: cocktail)
      ingredients = found_cocktail_list[cocktail]
      ingredients.each do |ingredient|
        one = Ingredient.create(name: ingredient)
        drink.ingredients << one
      end
      self.cocktails << drink
    else
      puts "Input not recognised."
    end
  end

  def search_ingredients
    puts "Let's search for cocktails with the ingredient you had in mind. Enter your ingredient:"
    ingredient = gets.chomp
    found_ingredient = Ingredient.internet_search_cocktails(ingredient)
  
    if found_ingredient
      found_ingredient.each do |name, ingredients|
        puts "name: #{name}"
        puts "ingredients: #{ingredients.join(", ")}"
      end
    else
      puts "Sorry, that ingredient could not be found."
    end
    puts "Type in the name of the cocktail you want to save into your favorites:"
    cocktail = gets.chomp
    if found_ingredient.include? cocktail
      drink = Cocktail.create(name: cocktail)
      ingredients = found_ingredient[cocktail]
      ingredients.each do |ingredient|
        one = Ingredient.create(name: ingredient)
        drink.ingredients << one
      end
      self.cocktails << drink
    else
      puts "Input not recognised."
    end
  end

  def print_saved_cocktails
    self.cocktails.each_with_index do |cocktail, index|
    puts "#{index +1}. #{cocktail.name}"
    end
  end
  
  def retrieve_user_favorites
  
    puts "Your saved cocktails are:"
    self.print_saved_cocktails
  end
  
  def add_new_favorite
  
  puts "Enter the name of the cocktail you want to add:"
  cocktail = gets.chomp
  found_cocktail = Cocktail.search_cocktails(cocktail)
  
    if self.cocktails.include? found_cocktail.first
      puts "This cocktail is already in your favorites. Your saved cocktails are:"
      self.print_saved_cocktails
  
    else
      self.cocktails << found_cocktail.first
      puts "#{found_cocktail.first.name} added to your favorites. Your saved cocktails are now:"
      self.print_saved_cocktails
    end
  end
  
  def delete_favorite
    retrieve_user_favorites
    puts "Enter the name of the cocktail that you want to remove:"
    cocktail_to_delete = gets.chomp
    found_cocktail = Cocktail.search_cocktails(cocktail_to_delete).first
    self.cocktails = self.cocktails.reject { |cocktail| cocktail == found_cocktail}
    puts "Your saved cocktails are now:"
    self.print_saved_cocktails
  end

  def update_rating
    puts "Let's update the rating for one of your favorite drinks! Enter the drink you want to update:"
    cocktail = gets.chomp
    found_cocktail = self.cocktails.find_by(name: cocktail.capitalize)
    if found_cocktail 
      puts "What rating would you give #{found_cocktail.name.downcase} on a scale of 1-10? 1 being the worst, and 10 being the best."
      updated_rating = gets.chomp.to_i
      # below line will update--> but it will also update if you have it in your favorites as well. buggy. need to fix.
      found_cocktail.user_cocktails.update(rating: updated_rating)
      puts "Thanks! Your rating for #{found_cocktail.name.downcase} is now #{updated_rating}."
    else
      puts "Sorry, that drink could not be found in your favorites list."
    end
  end

  def leave
    puts "Thanks for using the cocktail app #{self.name}. See you soon."
  end

end