function sorted(t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end
local authors = {}      -- a set to collect authors
function Entry (t) authors[t.author] = t end
dofile("entry.lua")
function show(x) 
	local q="\""
	return type(x) == "string" and q..x..q  or x
end
for _,v in sorted(authors) do 
	local sep = ""
	io.write("\nEntry{")
	for k,v2 in sorted(v) do
		io.write(sep,"\n\t",k," = ",show(v2))
		sep=","
 	end
	print("\n}")
end
