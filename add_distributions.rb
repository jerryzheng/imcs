#!/usr/bin/env ruby

#date, description, distribution_type, item_type, fund_id, investor_id, amount

require 'csv'

csv_file = ARGV[0]

#puts csv_file

newline = "";

CSV.foreach(csv_file, quote_char: '"', col_sep: ',', row_sep: :auto) do |row|
   distribution_data = "INSERT INTO im_distributions (description, date, fund_id, distribution_type) VALUES
('#{row[1]}', STR_TO_DATE('#{row[0]}', '%c/%e/%y'), #{row[4]}, '#{row[2]}');"
   if newline != distribution_data
 	puts distribution_data
 	puts
 	newline = distribution_data
   end
   item_data = "INSERT INTO im_distribution_items (amount, investor_id, distribution_id, position_id, item_type)
SELECT #{row[6]}, #{row[5]}, d.id, p.id, '#{row[3]}'
FROM im_distributions d, im_positions p  
WHERE p.fund_id = #{row[4]} and p.investor_id = #{row[5]} and d.fund_id = p.fund_id
and d.description = '#{row[1]}' and distribution_type = '#{row[2]}' and DATE_FORMAT(date, '%c/%e/%y') = '#{row[0]}';"
   puts item_data
   puts
end

