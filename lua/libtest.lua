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

check{copyleft = 
    (function() return copyleft("THING") and true;  end) 
}
check{round = 
    (function() return round(2.312,2) == 2.31 end)
}
check{sd =
      (function() return 30.28 == round(sd(550,38500,10),2) end)
}
check{show =
      (function() return show(1,2,3,4,true,nil,7) ==
         "1:1; 2:2; 3:3; 4:4; 5:true; 6:nil; 7:7; "
    end)
}
check{rep =
    (function() return rep(10,"x") == "xxxxxxxxxx" end)
}
check{plain =
    (function() return plain("i love\n traffic\t lights")
                        == "ilovetrafficlights" end)
}
check{oo = (function() 
   local str = [[
   a: 1
   h:  
      i: true
      j: 23.2
   c:  
      e: 3
      d: 2
      f: true
   g: 23
   ]]
   return plain(str) == 
         plain(
	   oo{ a=1,b=nil,
               c={d=2,e=3,f=true},
               g=23,
               h={i=true,j=23.2}})
   end)
}
check{inc1 = 
    (function() 
	t={}; 
	inc1(t,"cats"); 
	inc1(t,"cats"); 
	return t["cats"] == 2 end)
}
check{inc2 = 
    (function() 
	t={}; 
	inc2(t,"cats","bats"); 
	inc2(t,"cats","bats"); 
	return t["cats"]["bats"] == 2 end)
}
check{inc3 = 
    (function() 
	t={}; 
	inc3(t,"cats","bats","rats"); 
	inc3(t,"cats","bats","rats"); 
	return t["cats"]["bats"]["rats"] == 2 end)
}
check{rows= (function  ()
   local out=""
   local function worker(line,lines,rownum,row)
      out = out .. lines .. rownum .. #row .. line .. "\n" 
   end
   rows("data/rowstest.txt",worker,";.*")
   return plain("201what,visualize") == plain(out)
end)
}
check{oop = (function ()
     local Stuff = Object:new{owner="tim", place="nthAmerica"}
     local Thing = Stuff:new{weight="1"}
     local thing1 = Stuff:new()
     local thing2 = Stuff:new()
     thing1.owner = "jade"
     return plain(show(thing1.owner,thing2.owner)) == "1:jade;2:tim;"
   end)}

check{oop = oopdemo}

check{test1 = (function () return true  end)}	      
check{test2 = (function () return false end)}	      
check{test2 = (function () return true  end)}
