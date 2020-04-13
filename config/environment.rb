require 'bundler'

Bundler.require

require_relative '../apps/models/user.rb'
require_relative '../apps/models/cocktail.rb'
require_relative '../apps/models/ingredient.rb'
require_relative '../apps/models/user_cocktail.rb'
require_relative '../apps/models/cocktail_ingredient.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
