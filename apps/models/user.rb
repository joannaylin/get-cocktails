class User < ActiveRecord::Base
  has_many :user_cocktails
  has_many :cocktails, through: :user_cocktails

  def print_saved_cocktails
    self.cocktails.each_with_index do |cocktail, index|
    puts "#{index +1}. #{cocktail.name}"
    end
  end

end