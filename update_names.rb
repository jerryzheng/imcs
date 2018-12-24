#!/usr/bin/env ruby
STDIN.read.split("\n").each do |row|
   columns = row.strip.split("|")
   puts  "UPDATE im_investors SET payee_name = \"#{columns[1]}\" WHERE id = #{columns[0]};" 
end

