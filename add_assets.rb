#!/usr/bin/env ruby
require 'csv'

csv_file = ARGV[0]

newline = "";

CSV.foreach(csv_file, quote_char: '"', col_sep: ',', row_sep: :auto) do |columns|
  puts "INSERT INTO im_assets (fund_id, name, property_type, num_units, description, created_at, updated_at)
        VALUES (#{columns[0]}, '#{columns[1]}', '#{columns[7]}', #{columns[8]}, '#{columns[9]}', now(), now());"
  puts
  puts "INSERT INTO im_addresses (asset_id, street1, street2,  city, state, postal_code, country_code)
        SELECT id, '#{columns[2]}', '#{columns[3]}', '#{columns[4]}', '#{columns[5]}', '#{columns[6]}', 'US'
        FROM im_assets where fund_id = #{columns[0]} and name = '#{columns[1]}';"
  puts

end

