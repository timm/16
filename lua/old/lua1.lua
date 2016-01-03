
function luas()
   local files= io.popen("ls *.lua")
   for file in files:lines() do
      if not (file == "main.lua") then 
	 print(file)
      end
   end
end

