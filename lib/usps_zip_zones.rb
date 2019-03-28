require 'active_record'
require_relative 'models/normal_zone'
require_relative 'models/exception_zone'
require_relative 'zone_calculator'
db_config = Psych.load(File.open(File.expand_path('../../db/config.yml', __FILE__)))
ActiveRecord::Base.establish_connection(db_config)
