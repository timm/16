fmt  = string.format
floor= math.floor
p    = function (x) return floor(0.5+ 100*x) end
empty= function (t) return next(t) == nil end

function items (lst)
   local i,max = 0, #lst 
   return function ()
    i = i + 1 
    if i <= max then  return lst[i] end end end 

for x in items({1,30,33})
  do print("z",x) end

function rep(n,c) 
   c = c or " "
   local out = ""
   for i=1,n do out = out .. c end
   return out
end
 
function o(data)print(oo(data)) end

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

o({1,2,b={l=12,m=100}, a=3})

function member(x,lst) 
  for y in items(lst) do
    if x== y then return true end end
  return false
end

function rogue(x) 
  local builtin = { "true","math","package","table","coroutine",
       "os","io","bit32","string","arg","debug","_VERSION","_G"}
  for k,v in pairs( _G ) do
    if type(v) ~= 'function' then  
       if not member(k, builtin) then 
         print(":rogue",k) end end end end
     
do
  local y,n = 0,0
  local function report() 
    print(fmt(":pass %s :fail %s :percentPass %s%%",
              y,n,p(y/(0.001+y+n))))
    rogue() end
  local function test(s,x) 
    print("# test:",s) 
    local passed,err = pcall(x) 
    if passed then y = y + 1 else
       n = n + 1
       print("Fails:",err) end end 
  local function tests(t)
    for s,x in pairs(t) do test(s,x) end end 
  function ok(t) 
    if empty(t) then report() else tests(t) end end
end 

rogue()

Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end