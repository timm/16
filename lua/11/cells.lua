----------------------------------------------------------------------
-- This file is part of LURE.
--
-- LURE is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- LURE is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with LURE.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------

-- needs lib.lua

---------------------------------------------------------------------

Cell = Object:new{name="",pos=0,isKlass=false,isIgnored=false}

function Cell:swallow(n)
   return n
end

--
-- Sym
--
Sym = Cell:new{counts={}}

function Sym:add(x) inc1(counts,x); return x;  end

function Sym:compile(x)
   return x
end

function Sym:halfway(sym1,sym2)
   if (sym1==sym2) then return sym1
   elseif math.random(100000) >= 50000 then 
      return sym1
   else return sym2
end end

-- first read, taste it. place raw type into row
-- second read, swallow it. place it into cooked
--
-- Num
--
Num = Cell:new{max= -1*10^32, min = 10^32,sum=0,sumSq=0,n=0,sd=0,mean=0}

-- taste: tentative peek. if ok, passed to raw
function Num:compile(x)
   x = tonumber(x)
   if x then return x else error(x .. "not a number") end
end
      
function Num:add(x)
   self.n = self.n + 1
   if (x > self.max) then self.max = x end
   if (x < self.min) then self.min = x end
   self.sum   = self.sum + x
   self.sumSq = self.sumSq + x*x
   self.mean = self.sum/self.n
   if (self.n > 1) then  
      self.sd = sd(self.sum,self.sumSq,self.n)
   end
   return x
end

function Num:halfway(num1,num2)
   return (num1 - num2) / 2
end

function Num:normalize(n)
   return (n - self.min) / (self.max - self.min)
end

function Num:nbins(n,bins)
   bins = bins or The.bins
   local bin = (n - self.min) / ((self.max - self.min) / bins)
   bin = 1 + math.floor(bin)
   if (bin > bins) then bin = bins end
   return bin
end




