require 'bundler'
require 'net/http'
require 'open-uri'
require 'json'

Bundler.require

require_relative '../apps/models/user.rb'
require_relative '../apps/models/cocktail.rb'
require_relative '../apps/models/ingredient.rb'
require_relative '../apps/models/user_cocktail.rb'
require_relative '../apps/models/cocktail_ingredient.rb'

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

ActiveRecord::Base.logger = nil

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)


