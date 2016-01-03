dofile("lib.lua")
Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

Account=Object:new{balance=0}

function Account:deposit(d) 
   self.balance = self.balance + d
end

function Account:withdraw (v)
   if v > self.balance then error"insufficient funds" end
   self.balance = self.balance - v
end


 a = Account:new{balance = 0}
    a:deposit(100.00)
  a:deposit(300.00)

SpecialAccount = Account:new()

function SpecialAccount:withdraw (v)
   if v - self.balance >= self:getLimit() then
      error"insufficient funds"
   end
   self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
   return self.limit or 0
end


s = SpecialAccount:new{limit=1000.00}

s:withdraw(200)
