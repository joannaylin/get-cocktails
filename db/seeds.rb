require_relative '../config/environment.rb'

User.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all
CocktailIngredient.destroy_all
UserCocktail.destroy_all 

# Users
sam = User.create(name: "Sam")
joanna = User.create(name: "Joanna")

# Cocktails
stormy = Cocktail.create(name: "Dark and Stormy")
margarita = Cocktail.create(name: "Margarita")
martini = Cocktail.create(name: "Martini")
aperol_spritz = Cocktail.create(name: "Aperol Spritz")

# Ingredients
rum = Ingredient.create(name: "Rum")
ginger_beer = Ingredient.create(name: "Ginger Beer")
tequila = Ingredient.create(name: "Tequila")
lime = Ingredient.create(name: "Lime Juice")
syrup = Ingredient.create(name: "Sugar Syrup")
gin = Ingredient.create(name: "Gin")
vermouth = Ingredient.create(name: "Dry Vermouth")
aperol = Ingredient.create(name: "Aperol")
prosecco = Ingredient.create(name: "Prosecco")
soda_water = Ingredient.create(name: "Soda Water")

# Cocktail Ingredients
stormy.ingredients << rum
stormy.ingredients << ginger_beer
margarita.ingredients << tequila 
margarita.ingredients << lime 
margarita.ingredients << syrup 
martini.ingredients << gin
martini.ingredients << vermouth 
aperol_spritz.ingredients << aperol
aperol_spritz.ingredients << prosecco
aperol_spritz.ingredients << soda_water

# User Cocktails
joanna.cocktails << margarita
joanna.cocktails << martini
sam.cocktails << martini
sam.cocktails << aperol_spritz