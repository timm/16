require "nsv"

function _nsv(f)
  f= f or 'data/weather.csv'
  for row in  Nsv:new{file=f}:rows() do
    print("[" .. implode(row) .. "]")
end end

-- _csv()
_nsv('data/maxwell.csv')
