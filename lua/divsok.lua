require "divs"
require "cols"
require "fun"

function _divs(n,s,d)
  n = {}
  for i = 1,1000 do add(n,r()^2) end
  s = Split:new{get=same,maxBins=4}
  for i,range in pairs(s:div(n)) do
    print(i,range.lo,range.up) end
  d= Fun:new()
  d:import('data/maxwell.csv')
  print(#d.nums)
end

_divs()


