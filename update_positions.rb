#!/usr/bin/env ruby


STDIN.read.split("\n").each do |row|
   columns = row.strip.split(',')

#puts "UPDATE im_investors SET external_id = #{columns[1]}, external_id_type ='apm' where id = #{columns[0]};"
#puts "UPDATE im_emails SET fund_uid = '#{columns[1]}' where id = #{columns[0]};"
puts "UPDATE im_positions SET ownership_percentage = #{columns[1]} where id = #{columns[0]};"


end

