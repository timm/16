require "cols"

function _some()
  local some = Some:new{max=32}
  rseed(1)
  for _ = 1,1000000 do
    some:keep(r())
  end
  print(implode(rns(3,sort(some.kept)), " "))
end

function _syms()
  local sym=Some:new{name="asdas"}
  rseed(1)
  words=[[To be or not to be that is the question]] 
end

_syms()
    
