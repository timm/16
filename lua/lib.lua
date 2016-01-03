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

function copyleft(this) local str= [[

-------------------------------------------------------------------
This file is part of ]] .. this .. [[.

]] .. this .. [[ is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

]] .. this .. [[ is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with ]] .. this .. [[.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------]]
   return string.gsub(str,'\n','\n-- ')
end

--
-- maths stuff
--
function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function sd(sum,sumSq,n) 
   return ((sumSq-((sum*sum)/n))/(n-1))^0.5;
end
--
-- string stuff
--

function shown(...) print(show1(arg)) end
function show(...) return show1(arg)  end 

function show1(arg)
   local str=""
   for i = 1,arg["n"] do
      str = str .. i .. ":" .. tostring(arg[i]) .. "; "
   end 
   return str
end

function rep(n,c) -- return a string with "n" repeats of "c"
   c = c or " "
   local out = ""
   for i=1,n do out = out .. c end
   return out
end

function plain(s) -- no upper, no white
   return string.lower(string.gsub(tostring(s),"[ \t\n\r]",""))
end

function o(data) -- print anything, even nested things
   print(oo(data)) 
end

function oo(data, indent)  -- convert anything to a string
   if(indent == nil) then indent = 0 end 
   local str,pad = "",rep(indent)
   if type(data) ~= "table" then 
      return pad .. tostring(data)
   end
   for i, v in pairs(data) do 
      str = str .. pad .. i .. ": "
      if(type(v) == "table") then 
	 str = str .." \n"  .. oo(v,indent+2)
      else 
	 str = str .. oo(v,0) .. "\n"
   end end
   return str
end

--
-- tables stuff 
--
function inc1(c,x) -- inc to zero
   c[x] = c[x] or 0
   c[x] = c[x] + 1
end

function inc2(c,x,y) -- inc 2d to zero
   c[x] = c[x] or {}
   c[x][y] = c[x][y] or 0
   c[x][y] = c[x][y] + 1
end

function inc3(c,x,y,z) -- inc 3d to zero
   c[x] = c[x] or {}
   c[x][y] = c[x][y] or {}
   c[x][y][z] = c[x][y][z] or 0
   c[x][y][z] = c[x][y][z] + 1
end	

--
-- sets
--
function hasnot(t,k)  
   return t[k] and false or true 
end

-- 
-- read file
--    delete comments
--    skip blank links
--    split each line on The.sep
--    call a function on each non blank split line
--    note: first non-blank line has rownum 0 
function rows(file,f,comments) -- files to lines
   local lines  = 0 -- number of lines
   local rownum = -1 -- number of non-empty lines
   local width  = 0
   comments = comments or The.comments
   for line in io.lines(file) do 
      lines = lines + 1
      line  = string.gsub(line,"[ \t]+","")
      line  = string.gsub(line, comments,"",1)
      local row,width = rows1(line,The.sep)
      if (width > 0) then
	 rownum = rownum + 1
	 f(line,lines,rownum,row)
end end end

function rows1(line,sep) -- lines to words
   local out,i={},0
   for value in line:gmatch(sep) do 
      i=i+1
      out[i]=value
   end
   return out,i
end

--
-- timing functions
--
function time(what,x,r)
   r = r or 10
   local start = os.clock()
   for i = 1,r do x() end
   return string.format("%s : %.7f secs each",
			what,(os.clock() - start)/r)
end

--
-- regression tests
--
-- e.g. 
-- check{test1 = (function() return 1 == 1 end),
--       test2 = (function() return 2 == 20 end),
--       test3 = (function() return 3 == 2 end)}
-- tests() -- runs all tests
do
   local testfuns,testnames,xindex={},{},{}
   local passed,failed=0,0
   -- define some tests
   function check(sometests) 
      for name,fun in pairs(sometests) do
	 if xindex[name] then
	    print("-- WARNING: repeated test name " .. name)
	 else
	    table.insert(testfuns,fun)
	    testnames[#testfuns] = name
	    xindex[name] = #testfuns 
   end end end
   -- run all tests
   function tests()
      passed,failed=0,0
      for i,testname in ipairs(testnames) do
	 test(testname,i)
      end
      if (passed + failed > 0) then
	 print("TOTAL: " .. 
	       round(100* passed/(passed + failed)) .. 
	       " % passed")
   end end  
   -- run one test
   function test(name,i)
      i = i or xindex[name]
      if not testfuns[i] then
	 failed = failed + 1
	 return print("-- WARNING: missing test function ".. name)
      end
      if (testfuns[i]() == true) then
	 passed = passed + 1
	 print("  passed: " .. name)
      else
	 print("X failed: " .. name)
	 failed = failed + 1
end end end

--
--  inheritance... in under 10 lines
--
Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

--
-- Place to store global options
--

The={comments="\%.*",dontknow="?",sep=","}
