function string:split( inSplitPattern, outResults )
   if not outResults then
      outResults = { }
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, 
						   theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( self, theStart ) )
   return outResults
end

-- t = {}
-- s = "from=world, to=Lua"
-- for k, v in string.gmatch(s, "(%w+)=(%w+)") do
--   t[k] = v
-- end


local data = {}
local rows = 0
for str in io.lines("weather.csv") do
   str = str .. ","
   local line={}
   string.split(str,",",line)
   -- rows = rows + 1; data[rows] = line
end

for _,line in ipairs(t) do
   for _,cell in ipairs(line) do
      io.write(cell .. " ")
   end
   print("")
end
--  s = table.concat(t, "\n") .. "\n"


