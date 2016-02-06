require "csvfile"

for x in line1('data/weather.csv') do
  print("[" .. x .. "]")
end
