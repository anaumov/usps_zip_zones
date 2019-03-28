require 'yaml'
require 'active_record'

postgres_config = { host: :localhost, database: :postgres, adapter: :postgresql }
db_config = Psych.load(File.open('db/config.yml'))

namespace :db do
  task :create do
    ActiveRecord::Base.establish_connection(postgres_config)
    ActiveRecord::Base.connection.create_database(db_config['database'])

    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Schema.define do
      create_table :normal_zones, force: true do |t|
        t.string :zip_from
        t.string :zip_to
        t.string :value
        t.boolean :exception
        t.string :filter
        t.index ['zip_from', 'zip_to'], name: 'zip_from_zip_to_regular'
      end
      create_table :exception_zones, force: true do |t|
        t.int4range :zip_from
        t.int4range :zip_to
        t.string :value
        t.string :filter
        t.index ['zip_from', 'zip_to'], name: 'zip_from_zip_to_exceptions'
      end
    end
  end

  task :drop do
    ActiveRecord::Base.establish_connection(postgres_config)
    ActiveRecord::Base.connection.drop_database(db_config['database'])
  end

  task :seed_normal do
    puts "Started normal zones seeding at #{Time.now}"
    normal_zones = File.read('db/seed/Format2.txt').split("\r\n")
    columns = %i(zip_from zip_to value exception filter)
    values = []
    normal_zones.each_with_index do |line, index|
      next if index.zero?

      zip_from = line[0..2]
      line[3..-1].scan(/.{2}/).each_with_index do |el, index|
        zip_to = (index + 1).to_s.rjust(3, '0')
        zone = el[0]
        filter = el[1]
        is_exception = !!filter.match(/[1abe]/)
        values << "('#{zip_from}', '#{zip_to}', #{zone}, #{is_exception}, '#{filter}')"
      end
    end

    ActiveRecord::Base.establish_connection(db_config)
    insert_sql = "INSERT INTO normal_zones (#{columns.join(',')}) VALUES #{values.join(', ')}"
    ActiveRecord::Base.connection.execute(insert_sql)
    puts "Finished normal zones seeding at #{Time.now}"
  end

  task :seed_exception do
    puts "Started exception zones seeding at #{Time.now}"
    exception_zones = File.read('db/seed/exception.txt').split("\r\n")
    columns = %i(zip_from zip_to value filter)
    values = []
    exception_zones.each_with_index do |line, index|
      next if index.zero?

      origin_zip_from = line[0..4]
      origin_zip_to = line[5..9]
      dest_zip_from = line[10..14]
      dest_zip_to = line[15..19]
      zone = line[20..21].to_i
      filter = line[22..23]
      values << "('[#{origin_zip_from}, #{origin_zip_to}]', '[#{dest_zip_from}, #{dest_zip_to}]', '#{zone}', '#{filter}')"
    end

    ActiveRecord::Base.establish_connection(db_config)
    insert_sql = "INSERT INTO exception_zones (#{columns.join(',')}) VALUES #{values.join(', ')}"
    ActiveRecord::Base.connection.execute(insert_sql)
    puts "Finished exception zones seeding at #{Time.now}"
  end
end
