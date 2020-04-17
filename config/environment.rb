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

require_all 'lib'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
ActiveRecord::Base.logger = nil

require 'tty-prompt'

