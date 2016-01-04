fmt  = string.format
floor= math.floor
p    = function (x) return floor(0.5+ 100*x) end
empty= function (t) return next(t) == nil end

function items(lst)
  return function()
    for _,x in pairs(lst) do return x end
end end  

function member(x,lst) 
  for _,v in pairs(lst) do
    if v == x then return true end end
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

Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end