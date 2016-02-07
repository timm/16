require "cols"

function _some()
  local some = Some:new{max=32}
  rseed(1)
  for _ = 1,1000 do
    some:keep(r())
  end
  print(implode(rns(3,sort(some.kept)), " "))
end

_some()
    
