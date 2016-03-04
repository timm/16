-- dofile("lib.lua")
Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

Account=Object:new{balance=0}

function Account:display()
	print(self.balance)
end
function Account:deposit(d) 
   self.balance = self.balance + d
end

function Account:withdraw (v)
   if v > self.balance then error"insufficient funds" end
   self.balance = self.balance - v
end

SpecialAccount = Account:new{limit=100} -- 'new' inherited from Object

function SpecialAccount:withdraw (v) -- overrides Account's widthdraw
   if v - self.balance >= self:getLimit() then
      error"insufficient funds"
   end
   self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
   return self.limit or 0
end


s1 = SpecialAccount:new() -- {limit=500.00}
-- s1:withdraw(200)   -- crashes

s2 = SpecialAccount:new{limit=1000} -- {limit=500.00}
s2:withdraw(200)   -- crashes

s2:display() -- inheriated from Account

a = Account:new{balance = 0}
a:deposit(100.00)
a:deposit(300.00)

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

rogue()
