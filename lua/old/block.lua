do
   local all={}
   local function f1(x) all[x] =1 end
   function f2(y) f1(y); print(all[y]) end
end
