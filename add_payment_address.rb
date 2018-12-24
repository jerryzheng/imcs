#!/usr/bin/env ruby

i = 3000

STDIN.read.split("\n").each do |row|
   columns = row.strip.split(",")

    puts "INSERT INTO im_addresses (id, contact_id, street1, street2, pobox, city, state, postal_code)
          VALUES (#{i}, #{columns[1]}, '#{columns[2]}', '#{columns[3]}', '#{columns[4]}', '#{columns[5]}', '#{columns[6]}', '#{columns[7]}');"     

    puts  "UPDATE im_investors SET payment_address_id = #{i} WHERE id = #{columns[0]};"
    i = i+1
    puts 
end

