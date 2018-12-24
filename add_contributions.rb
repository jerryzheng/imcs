#!/usr/bin/env ruby


STDIN.read.split("\n").each do |row|
   columns = row.strip.split(',')

puts "INSERT INTO im_capital_call_items (capital_call_id, position_id, requested_date, due_date, amount)
      SELECT c.id, p.id, STR_TO_DATE('#{columns[3]}' , '%c/%e/%Y'), STR_TO_DATE('#{columns[3]}', '%c/%e/%Y'), #{columns[2]}
      FROM im_capital_calls c,  im_positions p
      WHERE c.fund_id = p.fund_id and p.fund_id = #{columns[0]} AND p.investor_id = #{columns[1]};"
puts

puts "INSERT INTO im_contributions (capital_call_item_id, date, amount, details)
      SELECT max(id), STR_TO_DATE('#{columns[3]}', '%c/%e/%Y'),  #{columns[2]}, '#{columns[4]}'
      FROM im_capital_call_items;"
puts

end

