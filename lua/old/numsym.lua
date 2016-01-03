
Num={}; Sym={}

function Num.new(name,data)
   local self   = {}
   local data   = data
   local klassp = false
   local name   = name
   local nbins  = 32
   local min    = 10^32
   local max    = -1 * min
   local bins   = {}
   function self.distance(v1,v2) return (v1 - v2)^2 end
   function self.normalize(x)    return (x - min) / (max - min) end
   function self.where ()
      if klass then return data.dnums else return data.nums end
   end
   function self.add(num,klass)
      if num > max then max = num end
      if num < min then min = num end
      local pos = math.floor(num/nbins) + 1
      if pos > nbins then pos = nbins end
      inc2(bins,pos,Data.every())
      inc2(bins,pos,klass)
   end
   return self
end

-- string to number is tonumber
--  x=0; if pcall(function () x="23a" + 0 end)  then print(x) else print("bad num") end
function Sym.new(name,data) 
   local self   = {}
   local data   = data
   local klassp = false
   local name   = name
   local bins   = {}
   function self.distance(v1,v2) if (v1 == v2) then return 0 else return 1 end  end 
   function self.add(x,klass)  
      inc2(bins,x,klass) 
      inc2(bins,x,Data.every())
   end
   function self.where()
      if klass then return data.dsyms else return data.syms end
   end
   return self
end

