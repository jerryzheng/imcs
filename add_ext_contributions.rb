#!/usr/bin/env ruby


STDIN.read.split("\n").each do |row|
   columns = row.strip.split(',')

puts "INSERT INTO im_capital_call_items (capital_call_id, position_id, requested_date, due_date, amount)
      SELECT c.id, p.id, STR_TO_DATE('#{columns[2]}' , '%c/%e/%Y'), STR_TO_DATE('#{columns[2]}', '%c/%e/%Y'), p.committed_amount
      FROM im_capital_calls c,  im_positions p, im_funds f, im_investors i
      WHERE   c.fund_id = p.fund_id and p.fund_id = f.id and f.external_id =  #{columns[0]} AND p.investor_id = i.id and i.external_id =  #{columns[1]};"
puts

puts "INSERT INTO im_contributions (capital_call_item_id, date, amount)
      SELECT id, requested_date, amount
      FROM im_capital_call_items t1 
      WHERE NOT EXISTS (select 1 from im_capital_call_items t2 where t2.id > t1.id);"
puts


end

