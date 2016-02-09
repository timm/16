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
  local sym=Some:new{name="asdas",max=10}
  rseed(1)
  local words=[[To be or not to be that is the question]] 
  for _,c in pairs(s2t(words)) do
    sym:keep(c)
  end
  for k,v in pairs(sym.kept) do 
    print(k,v)
  end
end

_syms()
    
