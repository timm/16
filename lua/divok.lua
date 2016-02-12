require "divs"
require "cols"

function _sdiv()
  local t={}
  for _ = 1,10^3 do add(t,r()^2) end
  local sp = Split:new{get=same}  
  for _,range in ipairs(sp:div(t)) do
     print(string.format("%2d | %.4f %.4f | %5d %.4f",
                        range.n, range.lo, range.up, 
                        #range.has, range.score.sd))
end end

_sdiv()
rogue()