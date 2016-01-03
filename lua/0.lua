-- reload every lua file (except me)
function make()
   local some = io.popen("ls *.lua") 
   for one in some:lines() do
      if (one ~= "0.lua") then 
	 print("-- loading " .. one)
	 dofile(one)
      end
   end
   some:close()
end

make()

