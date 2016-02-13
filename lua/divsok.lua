require "divs"
require "cols"

function _split()
  local n = {}
  for i = 1,1000 do add(n,r()^2) end
  s = Split:new{get=same}
  for i,range in pairs(s:div(n)) do
    print(i,range.lo,range.up) end
end

_split()


