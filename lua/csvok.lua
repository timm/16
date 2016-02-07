require "csv"

for row in Csv:new{file='data/weather.csv'}
                :rows() do
    print("[" .. implode(row) .. "]")
end

rogue()
