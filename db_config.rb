
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'moe_diesel'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
