require "aaa"

Sub1 = Object:new{a=1,b=2}
function Sub1:s() return "Sub1".. tstring(self) end
function Sub1:fred(   out)
  out=''
  for i,n in ipairs(self) do
    out = out..i..n end
  return out..'}'
end

Sub2 = Sub1:new{c=1,d=2}

x = Sub2:new()
print(x:fred())
tprint(x)


Sub3 = Sub2:new{e=1,f=2}
function Sub3:s() return "Sub311111" end

Sub4 = Sub3:new{kkk=20,zzz=20}

s1 = Sub1:new()
s2 = Sub2:new()
s3 = Sub3:new()
s4 = Sub4:new()

print(s1,s2,s3,s4)