require "csv"

function _csv(f)
  f= f or 'data/weather.csv'
  for row in  Csv:new{file=f}:rows() do
    print("[" .. implode(row) .. "]")
end end

-- _csv()
_csv('data/maxwell.csv')
