class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

  # search for cocktails by name in api
  def search_cocktails
    space
    puts Pastel.new.magenta("Let's search for a cocktail. Enter the cocktail you want to see:")
    cocktail = gets.chomp
    found_cocktail_list = Cocktail.internet_cocktails(cocktail)

    if found_cocktail_list
      space
      self.print_search_results(found_cocktail_list)
      self.add_favorite(found_cocktail_list)
    else
      space
      puts Pastel.new.red("Sorry, that cocktail could not be found.")
    end
  end

  # search for cocktails by ingredients in api
  def search_ingredients
    space
    puts Pastel.new.magenta("Let's search for cocktails with the ingredient you had in mind. Enter your ingredient:")
    ingredient = gets.chomp
    found_ingredient = Ingredient.multiple_search_cocktails(ingredient)
    if found_ingredient
      self.print_search_results(found_ingredient)
      self.add_favorite(found_ingredient)
    else
      space
      puts Pastel.new.red("Sorry, that ingredient could not be found.")
    end
  end

  # helper method
  # prints formatted cocktail name, ingredients, and instructions
  def print_search_results(search_results)
    search_results.each do |drink|
      puts ""
      puts Pastel.new.cyan.bold("Name: #{drink[:name]}")
      puts ""
      puts Pastel.new.underline("Ingredients:")
      drink[:ingredients].each { |ingredient, measure| puts "#{ingredient}: #{measure}"}
      puts ""
      puts Pastel.new.underline("Instructions:") 
      puts "#{drink[:instructions]}"
      puts ""
      puts "*************"
    end
  end

  # helper method
  # handles input for saving cocktail in favorites
  def add_favorite(search_results)
    arr = ["Yes", "No"]
    if search_results.length == 1
      favorite = search_results.first[:name]
      space
      answer = TTY::Prompt.new.select("Do you want to add this cocktail to your favorites?", arr)
      if answer == "Yes"
        save_favorite(search_results, favorite)
      end

    elsif search_results.length > 1
      space
      answer = TTY::Prompt.new.select("Do you want to add one of these cocktails to your favorites?", arr)
      if answer == "Yes"
        space
        names = search_results.map { |cocktail| cocktail[:name] }
        input = TTY::Prompt.new.select("Which cocktail do you want to add?", names)
        save_favorite(search_results, input)
      end
    end
  end
  # helper method
  # saves cocktail into favorites, mainting name, instructions, ingredients, and measurements
  def save_favorite(search_results, favorite)
    search_results.each do |cocktail|
      if cocktail[:name] == favorite
        if !Cocktail.find_by(name: cocktail[:name], instructions: cocktail[:instructions])
          drink = Cocktail.create(name: cocktail[:name], instructions: cocktail[:instructions])
          ingredients = cocktail[:ingredients]
          ingredients.each do |ingredient, measure|
            item = Ingredient.find_or_create_by(name: ingredient, measure: measure)
            drink.ingredients << item
          end
        else
          drink = Cocktail.find_by(name: cocktail[:name], instructions: cocktail[:instructions])
        end

        if self.cocktails.include? drink
          space
          puts Pastel.new.red("You've already added this drink to your favorites.")
        else
          self.cocktails << drink
            space
            puts Pastel.new.magenta("#{drink.name} has been added to your favorites.")
        end
      end
    end
  end

  # prints users favorites 
  def print_saved_cocktails
    if self.cocktails.length > 0
      space
      puts Pastel.new.magenta("Your saved cocktails are:")
      self.cocktails.each_with_index do |cocktail, index|
        mine = cocktail.user_cocktails.where(:user_id => self.id, :cocktail_id => cocktail.id)
        rating = mine.first.rating
        puts ""
        puts "#{index +1}. #{cocktail.name} -- rating: #{rating}"
        puts Pastel.new.underline("Ingredients:")
          cocktail.ingredients.each { |ingredient| puts "#{ingredient.name}: #{ingredient.measure}"}
        puts ""
        puts Pastel.new.underline("Instructions:")
        puts "#{cocktail.instructions}"
        puts ""
        puts "******************"
      end
      puts drink3
    else
      space
      puts Pastel.new.red("You have no saved cocktails to display, #{self.name}.")
    end
  end

  # removes cocktail from users favorites 
  def delete_favorite
    if self.cocktails.length > 0
      space
      self.print_saved_cocktails
      space
      names = self.cocktails.map { |cocktail| cocktail[:name] }
      cocktail_to_delete = TTY::Prompt.new.select("Which cocktail do you want to remove?", names)
      self.cocktails = self.cocktails.reject { |cocktail| cocktail.name == cocktail_to_delete}
      space
      puts Pastel.new.magenta("#{cocktail_to_delete} has been removed from your favorites. Your saved cocktails are now:")
      self.print_saved_cocktails
    else
      self.print_saved_cocktails
    end
  end

  # update rating for cocktail in users favorites 
  def update_rating
    if self.cocktails.length > 0
      space
      puts Pastel.new.magenta("Let's update the rating of one of your drinks!")
      puts Pastel.new.italic("Your current favorites are: ")
      space
      self.print_saved_cocktails
      space
      names = self.cocktails.map { |cocktail| cocktail[:name] }
      cocktail_to_update = TTY::Prompt.new.select("What drink would you like to update?", names)
      found_cocktail = self.cocktails.find_by(name: cocktail_to_update)
      space
      updated_rating = TTY::Prompt.new.select("What rating would you give #{found_cocktail.name} on a scale of 1-10? 1 being the worst, and 10 being the best.", (1..10).to_a)
      cocktail = found_cocktail.user_cocktails.where(:user_id => self.id)
      cocktail.update(rating: updated_rating)
      puts Pastel.new.italic("Thanks! Your updated favorites are: ")
      self.print_saved_cocktails
    else
      self.print_saved_cocktails
    end
  end

  # exit app/menu
  def leave
    pastel = Pastel.new
    puts pastel.italic.bold.cyan("Thanks for using the Cocktail app #{self.name}. See you soon.")
  end

end