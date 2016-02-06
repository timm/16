require "csvfile"

for row in csvFile("data/weather.csv") do 
  for i = 1,#row do
    io.write("["..row[i].."]",":",type(row[i])," ")
  end
  io.write("\n")
end

rogue()
