#!/usr/bin/env ruby


STDIN.read.split("\n").each do |row|
   columns = row.strip.split(',')

puts "UPDATE im_positions  SET capital_balance_forward_amount = #{columns[2]},  capital_balance_forward_on = STR_TO_DATE('#{columns[1]}', '%c/%e/%Y') WHERE id = #{columns[0]};"

end

