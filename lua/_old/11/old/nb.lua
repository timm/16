function make() 
   dofile("lib.lua")
   dofile("nb.lua")
end

function nb(line,rowNum,row,the)
   print("");
   local target = the.target > 0 and the.target or #row + 1 + the.target
   local klass  = row[target]
   local function usable(col) 
      return hasnot(the.ignore,col) and col ~= target and row[col] ~= the.unknown 
   end
   local function classify() 
      local likes, what, all = -1000000, '', the.klasses[the.every]
      for klass,n in ipairs(the.counts) do
	 if (klass ~= the.every) then
	    local prior = (n + the.k)/(all + (#the.klasses-1)*the.k)
	    local temp  = math.log(prior)
	    for col,cols in the.counts[klass] do
	       if usable(col)  then
		  local e = cols[col][row[col]] or 0 
		  temp = temp + math.log((e + the.m*prior)/(n + the.m)) 
	    end end
	    if (temp > likes) then like=temp;what=klass 
      end end end
      return what 
   end
   if (rowNum >= the.enough) then print (klass .. classify())  end
   inc1(the.klasses,klass)
   inc1(the.klasses,the.every)
   for col,value in pairs(row)  do
      if usable(col) then inc3(the.counts,klass,col,value) 
end end end

function main(file)
   local the={k=1,m=2,enough=5,every='*',unknown='?',
	      target=-1,ignore={},counts={},klasses={}}
   rows(file,function (line,row,num) nb(line,num,row,the) end )
end

function _nb1() make(); main("weather.lua") end



