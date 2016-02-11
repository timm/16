require "divs"
require "cols"

function _sdiv()
  local t={}
  for _ = 1,100 do add(t,r()^3) end
  local sp = Split:new{get=same}
  sp:div(t)
end

_sdiv()