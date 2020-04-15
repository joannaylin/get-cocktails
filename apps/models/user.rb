class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

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
      updated_rating = gets.chomp
      # below line will update--> but it will also update if you have it in your favorites as well. buggy. need to fix.
      found_cocktail.user_cocktails.update(rating: updated_rating.to_i)
      puts "Thanks! Your rating has now been updated."
      # trying to get it to print a result back to the user so that they can visually see the update, but no dice. need to fix.
    else
      puts "Sorry, that drink could not be found in your favorites list."
    end
  end

  def leave
    puts "Thanks for using the cocktail app #{self.name}. See you soon."
  end

end