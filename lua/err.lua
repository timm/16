fmt  = string.format
floor= math.floor
p    = function (x) return floor(0.5+ 100*x) end

do
  local y,n = 0,0
  function ok( tests ) 
    for _,test in pairs(tests) do  
      print("for",test != nil)
      passed,err = pcall(test) 
      if passed then y = y + 1 else
        n = n + 1
        print("Fails:",err)
      end 
    end 
    print("ok",test != nil)
  end
  function status()
    print(fmt(":y %s :n %s :percent %s%%",
          y,n,p(y/(0.001+y+n))))
end end  

function aa() assert(2==1,"ads")  assert(1==1,"aa")   end
function bb() assert(1==1,"-----")  end

ok{aa, bb}
status() 

print(test)
