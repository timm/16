require "divs"
require "cols"

function _sdiv()
  local t={}
  for _ = 1,10^4 do add(t,r()^4) end
  local sp = Split:new{get=same}
  sp:div(t)
end

_sdiv()