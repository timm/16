require "cols"

function _cols()
  n = Num:new()
  for i=1,1000 do
    n.add(r()^3)
  end
  print(n)
end

_cols()