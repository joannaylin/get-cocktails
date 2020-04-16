class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

  def search_cocktails
    space
    puts "Let's search for a cocktail. Enter a cocktail you want to see:"
    cocktail = gets.chomp
    found_cocktail_list = Cocktail.internet_cocktails(cocktail)
  
    if found_cocktail_list
      self.print_search_results(found_cocktail_list)
    else
      space
      puts "Sorry, that cocktail could not be found."
    end
    self.add_favorite(found_cocktail_list)
  end

  def search_ingredients
    space
    puts "Let's search for cocktails with the ingredient you had in mind. Enter your ingredient:"
    ingredient = gets.chomp
    found_ingredient = Ingredient.internet_search_cocktails(ingredient)
    # found_ingredient = Ingredient.multiple_search_cocktails(ingredient)
  
    if found_ingredient
      self.print_search_results(found_ingredient)
    else
      puts ""
      puts "- - - - - - - - - - - - -"
      puts ""
      puts "Sorry, that ingredient could not be found."
    end

    # puts "Type in the name of the cocktail you want to save into your favorites:"
    # favorite_cocktail = gets.chomp
    # found_ingredient.each do |cocktail|
    #   if cocktail[:name] == favorite_cocktail
    #     drink = Cocktail.create(name: cocktail[:name], instructions: cocktail[:instructions])
    self.add_favorite(found_ingredient)
  end

  def print_search_results(search_results)
    search_results.each do |drink|
      puts "Name: #{drink[:name]}"
      puts "Ingredients:"
      drink[:ingredients].each { |ingredient, measure| puts "#{ingredient}: #{measure}"}
      puts "Instructions: #{drink[:instructions]}"
      puts ""
      puts "*************"
    end
  end

  def add_favorite(search_results)
    if search_results.length == 1
      puts ""
      puts "- - - - - - - - - - - "
      puts ""
      puts "Do you want to add this cocktail your favorites? (Y/N)"
      answer = gets.chomp
      if answer == "Y"
        save_favorite(search_results)
      end

    elsif search_results.length > 1
      puts ""
      puts "- - - - - - - - - - - - -"
      puts ""
      puts "Do you want to add one of these cocktails to your favorites? (Y/N)"
      answer = gets.chomp
      if answer == "Y"
        puts ""
        puts "- - - - - - - - - - - - -"
        puts ""
        puts "Which cocktail do you want to add?"
        favorite = gets.chomp
        save_multi_favorite(search_results, favorite)
      end
    end
  end

  def save_favorite(search_results)
    search_results.each do |cocktail|
      drink = Cocktail.find_or_create_by(name: cocktail[:name], instructions: cocktail[:instructions])
      ingredients = cocktail[:ingredients]
      ingredients.each do |ingredient, measure|
        one = Ingredient.find_or_create_by(name: ingredient, measure: measure)
        drink.ingredients << one
        end
        if self.cocktails.include? drink
          puts ""
          puts "- - - - - - - - - - - - -"
          puts ""
          puts "You've already added this drink to your favorites."
        else
          self.cocktails << drink
          puts ""
          puts "- - - - - - - - - - - - -"
          puts ""
          puts "#{drink.name} has been added to your favorites."
        end
    end
  end

  def save_multi_favorite(search_results, favorite)
    search_results.each do |cocktail|
      if cocktail[:name] == favorite
        drink = Cocktail.find_or_create_by(name: cocktail[:name], instructions: cocktail[:instructions])
        ingredients = cocktail[:ingredients]
        ingredients.each do |ingredient, measure|
          item = Ingredient.find_or_create_by(name: ingredient, measure: measure)
          drink.ingredients << item
          end
          if self.cocktails.include? drink
            puts ""
            puts "- - - - - - - - - - - - -"
            puts ""
            puts "You've already added this drink to your favorites."
          else
            self.cocktails << drink
            puts ""
            puts "- - - - - - - - - - - - -"
            puts ""
            puts "#{drink.name} has been added to your favorites."
          end
      end
    end
  end

  def retrieve_user_favorites
    puts ""
    puts "- - - - - - - - - - - - -"
    puts ""
    puts "Your saved cocktails are:"
    self.print_saved_cocktails
  end

  def print_saved_cocktails
    self.cocktails.each_with_index do |cocktail, index|
    # ingredients = cocktail.ingredients.map {|ingredient| ingredient.name}.join(", ")
    mine = cocktail.user_cocktails.where(:user_id => self.id, :cocktail_id => cocktail.id)
    rating = mine.first.rating
    puts ""
    puts "#{index +1}. #{cocktail.name} -- rating: #{rating}"
    puts "Ingredients:"
      cocktail.ingredients.each { |ingredient| puts "#{ingredient.name}: #{ingredient.measure}"}
    puts "Instructions: #{cocktail.instructions}"
    puts ""
    puts "******************"
    end
  end
  
  def delete_favorite
    retrieve_user_favorites
    puts ""
    puts "- - - - - - - - - - - - -"
    puts ""
    puts "Enter the name of the cocktail that you want to remove:"
    cocktail_to_delete = gets.chomp
    if found_cocktail = Cocktail.search_cocktails(cocktail_to_delete).first
      self.cocktails = self.cocktails.reject { |cocktail| cocktail.name == found_cocktail.name}
      puts "#{found_cocktail.name} has been removed from your favorites. Your saved cocktails are now:"
      self.print_saved_cocktails
    end
  end

  def update_rating
    puts "Let's update the rating of one of your drinks!"
    puts "Your current favorites are: "
    self.print_saved_cocktails
    puts ""
    puts "What drink would you like to update?"
    cocktail = gets.chomp
    found_cocktail = self.cocktails.find_by(name: cocktail)
    if found_cocktail 
      puts ""
      puts "What rating would you give #{found_cocktail.name} on a scale of 1-10? 1 being the worst, and 10 being the best."
      updated_rating = gets.chomp
      cocktail = found_cocktail.user_cocktails.where(:user_id => self.id)
      cocktail.update(rating: updated_rating)
      puts ""
      puts "Thanks! Your updated favorites are: "
      self.print_saved_cocktails
    else
      puts "Sorry, that drink could not be found in your favorites list."
    end
  end

  def leave
    puts "Thanks for using the Cocktail app #{self.name}. See you soon."
  end

end