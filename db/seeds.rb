require_relative '../config/environment.rb'

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

# User Cocktails