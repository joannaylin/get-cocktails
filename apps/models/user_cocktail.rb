class UserCocktail < ActiveRecord::Base
  belongs_to :user 
  belongs_to :cocktail

  # def initialize(user, cocktail, rating=nil)
  #   @user_id = user.id
  #   @cocktail_id = cocktail.id
  #   @rating = rating
  # end

end