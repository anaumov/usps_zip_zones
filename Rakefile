require 'yaml'
require 'active_record'

postgres_config = { host: :localhost, database: :postgres, adapter: :postgresql }
app_config = Psych.load(File.open('db/config.yml'))

namespace :db do
  task :create do
    # create database
    ActiveRecord::Base.establish_connection(postgres_config)
    ActiveRecord::Base.connection.create_database(app_config['database'])

    # run migrations
    ActiveRecord::Base.establish_connection(app_config)
    ActiveRecord::Schema.define do
      create_table :regular_distances, force: true do |t|
        t.string :zip_from
        t.string :zip_to
        t.string :zone
        t.boolean :exception
        t.string :filter
        t.index ['zip_from', 'zip_to'], name: 'zip_from_zip_to_regular'
      end
      create_table :exception_distances, force: true do |t|
        t.int4range :zip_from
        t.int4range :zip_to
        t.string :zone
        t.string :filter
        t.index ['zip_from', 'zip_to'], name: 'zip_from_zip_to_exceptions'
      end
    end
  end

  task :drop do
    ActiveRecord::Base.establish_connection(postgres_config)
    ActiveRecord::Base.connection.drop_database(app_config['database'])
  end

  task :seed_regular do
    puts "Started at #{Time.now}"
    regular_distances_data = File.read('db/seed/Format2.txt').split("\r\n")
    values = []
    regular_distances_data.each_with_index do |line, index|
      next if index.zero?

      origin_zip = line[0..2]
      line[3..-1].scan(/.{2}/).each_with_index do |zone, index|
        dest_zip = index.to_s.rjust(3, '0')
        values << "('#{origin_zip}', '#{dest_zip}', #{zone[0]}, #{zone[1].empty?}, '#{zone[1]}')"
      end
    end
    ActiveRecord::Base.establish_connection(app_config)
    column_names = %i(zip_from zip_to zone exception filter)
    insert_sql = "INSERT INTO regular_distances (#{column_names.join(',')}) VALUES #{values.join(', ')}"
    ActiveRecord::Base.connection.execute(insert_sql)
    puts "Finished at #{Time.now}"
  end

  task :seed_exception do
    puts "Started at #{Time.now}"
    exception_distances_data = File.read('db/seed/exception.txt').split("\r\n")
    values = []
    exception_distances_data.each_with_index do |line, index|
      next if index.zero?

      origin_zip_from = line[0..4]
      origin_zip_to = line[5..9]
      dest_zip_from = line[10..14]
      dest_zip_to = line[15..19]
      zone = line[20..21]
      filter = line[22..23]
      values << "('[#{origin_zip_from}, #{origin_zip_to}]', '[#{dest_zip_from}, #{dest_zip_to}]', '#{zone}', '#{filter}')"
    end
    ActiveRecord::Base.establish_connection(app_config)
    column_names = %i(zip_from zip_to zone filter)
    insert_sql = "INSERT INTO exception_distances (#{column_names.join(',')}) VALUES #{values.join(', ')}"
    ActiveRecord::Base.connection.execute(insert_sql)
    puts "Finished at #{Time.now}"
  end
end
