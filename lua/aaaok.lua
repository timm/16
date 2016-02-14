require "aaa"

function _test1()
  assert(1==1,"or else")
  assert(2==1,"oh dear") 
end

function _test2()
  assert(3==3,"or else")
  assert(4==3,"oh dear,again") 
end

function _maths() 
  assert(r3(9.87654321) == 9.877 , "round to 3 error")
  assert(round(3.6)==4           , "rounding error"  )
end

function _lists(t)
  t={10,20,30,40}
  assert(first(t) == 10,"first error")
  assert(last(t) == 40,"first error")
  assert(empty({}),"empty error")
  t=  sort{10,1,20,2} 
  assert(t[1]==1 and t[2]==2 
         and t[3]== 10 and t[4] == 20,
        "bad sort")  
  
end

ok{_test1,_test2, _maths,_lists}


os.exit()


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