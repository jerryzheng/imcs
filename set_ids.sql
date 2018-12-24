#!/usr/bin/env ruby


STDIN.read.split("\n").each do |row|
   columns = row.strip.split(',')

puts "UPDATE im_funds SET external_id = #{columns[1]}, external_id_type ='apm' where id = #{columns[0]};"


end

