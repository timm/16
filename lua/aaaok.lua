require "aaa"

Fred=Object:new{a=1,b=2}

f= Fred:new()
print(f.a)
for k,v in ipairs(f) do
  print(k,v)
end 

print(f.a,f)