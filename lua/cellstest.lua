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

check{numadd1 = 
      (function ()
	  local x=Num:new()
	  for i = 1,10 do
	     x:add(i*10)
	  end
	  return x.mean == 55 and  round(x.sd,2) == 30.28 -- 55, 30.2765
       end)
}
check{numadd2 = 
      (function () 
	  local function worker() 
	     local n=Num:new() 
	     for i=1,1000 do n:add(i) 
	  end end
	  print("  " .. time("numadd2",worker,10))
	  return true
       end)
}
