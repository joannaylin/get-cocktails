class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

  def search_cocktails
    space
    puts "Let's search for a cocktail. Enter the cocktail you want to see:"
    cocktail = gets.chomp
    found_cocktail_list = Cocktail.internet_cocktails(cocktail)

    if found_cocktail_list
      self.print_search_results(found_cocktail_list)
      self.add_favorite(found_cocktail_list)
    else
      space
      puts "Sorry, that cocktail could not be found."
    end
  end

  def search_ingredients
    space
    puts "Let's search for cocktails with the ingredient you had in mind. Enter your ingredient:"
    ingredient = gets.chomp
    found_ingredient = Ingredient.multiple_search_cocktails(ingredient)
    if found_ingredient
      self.print_search_results(found_ingredient)
      self.add_favorite(found_ingredient)
    else
      space
      puts "Sorry, that ingredient could not be found."
    end
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
      space
      prompt = TTY::Prompt.new
      answer = prompt.select("Do you want to add this cocktail to your favorites?") do |menu|
        menu.enum '.'
        menu.choice 'Yes', 1
        menu.choice 'No', 2
      end
      if answer == 1
        save_favorite(search_results)
      end

    elsif search_results.length > 1
      space
      prompt = TTY::Prompt.new
      answer = prompt.select("Do you want to add one of these cocktails to your favorites?") do |menu|
        menu.enum '.'
        menu.choice 'Yes', 1
        menu.choice 'No', 2
      end
      if answer == 1
        space
        names = search_results.map { |cocktail| cocktail[:name] }
        prompt = TTY::Prompt.new
        input = prompt.select("Which cocktail do you want to add?", names)
        save_multi_favorite(search_results, input)
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
          space
          puts "You've already added this drink to your favorites."
        else
          self.cocktails << drink
          space
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
            space
            puts "You've already added this drink to your favorites."
          else
            self.cocktails << drink
            space
            puts "#{drink.name} has been added to your favorites."
          end
      end
    end
  end

  def print_saved_cocktails
    if self.cocktails.length > 0
      space
      puts "Your saved cocktails are:"
      self.cocktails.each_with_index do |cocktail, index|
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
    else
      space
      puts "You have no saved cocktails to display, #{self.name}."
    end
  end

  def delete_favorite
    if self.cocktails.length > 0
      space
      self.print_saved_cocktails
      space
      names = self.cocktails.map { |cocktail| cocktail[:name] }
      prompt = TTY::Prompt.new
      cocktail_to_delete = prompt.select("Which cocktail do you want to remove?", names)

      if found_cocktail = Cocktail.search_cocktails(cocktail_to_delete).first
        self.cocktails = self.cocktails.reject { |cocktail| cocktail.name == found_cocktail.name}
        space
        puts "#{found_cocktail.name} has been removed from your favorites. Your saved cocktails are now:"
        self.print_saved_cocktails
      end
    else
      self.print_saved_cocktails
    end
  end

  def update_rating
    if self.cocktails.length > 0
      space
      puts "Let's update the rating of one of your drinks!"
      puts "Your current favorites are:"
      space
      self.print_saved_cocktails
      space
      names = self.cocktails.map { |cocktail| cocktail[:name] }
      prompt = TTY::Prompt.new
      cocktail_to_update = prompt.select("What drink would you like to update?", names)
      found_cocktail = self.cocktails.find_by(name: cocktail_to_update)
      if found_cocktail 
        space
        prompt = TTY::Prompt.new
        updated_rating = prompt.select("What rating would you give #{found_cocktail.name} on a scale of 1-10? 1 being the worst, and 10 being the best.", (1..10).to_a)
        cocktail = found_cocktail.user_cocktails.where(:user_id => self.id)
        cocktail.update(rating: updated_rating)
        self.print_saved_cocktails
      else
        puts "Sorry, that drink could not be found in your favorites list."
      end
    else
      self.print_saved_cocktails
    end
  end

  def leave
    puts "Thanks for using the Cocktail app #{self.name}. See you soon."
  end

end