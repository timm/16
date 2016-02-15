fmt   = string.format
odd   = function (x) return x % 2 == 1 end
even  = function (x) return not odd(x) end
floor = math.floor
p     = function (x) return floor(0.5+ 100*x) end
empty = function (t) return next(t) == nil end

function items (lst)
   local i,max = 0, #lst 
   return function ()
    i = i + 1 
    if i <= max then  return lst[i] end end end 

function rep(n,c) 
   c = c or " "
   local out = ""
   for i=1,n do out = out .. c end
   return out
end

function trim(s) 
  if s then
    return s:gsub("^%s+", ""):gsub("%s+$", "")
  else 
    return s
end end

function o(data) print(oo(data)) end

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
 
function member(x,lst)
  for y in items(lst) do
    if x== y then return true end end
  return false
end

function eval(s)
  return loadstring('return ' .. s)()
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

BLOCK=Object:new{valid=false,str=''}

UL   = BLOCK:new{level=0}
LI   = BLOCK:new()
OL   = BLOCK:new{level=0}
P    = BLOCK:new()
HEAD = BLOCK:new()

pat = {item= "^([%s]+)([\+\-%d])([\.]?)(.*)$"}

function moreBlocks(lines) 
  local out,line,newList,_
  line,_ = string.gsub(lines[1],pat.item,"$4")
  for i in 2,#lines 
    line,new = string.gsub(lines[1],pat.item,"$4")
    if new == 0 then out = out .. '\n' .. line end
    if new == 1 then return out end
    if new == 1 then out = line   end 
  end
end
    
x,y =string.gsub(
    "--abc s",
    "^(-[-]+)([^%s]+)%s(.*)$",
    "[%2]"
)

print(x)
print(y)
print(tonumber("3.0 "))
