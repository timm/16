require "data"

function _data(f)
  f= f or 'data/weather.csv'
  Data:new():import(f) 
end

-- _csv()
_data('data/maxwell.csv')
