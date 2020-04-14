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

end