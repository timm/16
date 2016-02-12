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
  local some=Some:new{name="asdas",max=10}
  local sym=Sym:new{name="asdas"}
  rseed(1)
  local words=[[To be or not to be that is the question]] 
  for _,c in pairs(s2t(words)) do
    some:keep(c)
    sym:add(c)
  end
  for k,v in pairs(sym.counts) do 
    print(k,v)
  end
  local num = Num:new{name="aaa"}
  for _,n in pairs{1,2,3,4,5,6} do
    num:add(n)
  end 
  print(num)
  local num1=num:copy()
  for i=1,1000 do num1:add(r()^3) end
  print(num)
  print(num1)
  tmp = Num:new():adds{1,2,3,4,5,6}.sd*0.1
  print(tmp)
end

_syms()
    
