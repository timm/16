fmt  = string.format
floor= math.floor
p    = function (x) return floor(0.5+ 100*x) end

do
  local y,n = 0,0
  local function tests(t)
          for _,x in pairs(t) do test1(x) end end 
  local function test1(x) 
          local passed,err = pcall(x) 
          if passed then y = y + 1 else
             n = n + 1
             print("Fails:",err) end end
  local function assess()
          print(fmt(":y %s :n %s :percent %s%%",
                    y,n,p(y/(0.001+y+n)))) end
  function ok( ... ) 
    t = { ... }
    if t['n'] == 0 then status() else assess(t) end end
end


function aa() assert(2==1,"ads")  assert(1==1,"aa")   end
function bb() assert(1==1,"-----")  end

ok(aa, bb)
ok() 
   
function has(x,lst) 
  for _,v in pairs(lst) do
    if v == x then return true 
  end end
  return false
end

aaa = 23

function rogue() 
  local builtin = { "true","math","package","table",
                     "coroutine","os","io","bit32",
                     "string","arg","debug","_VERSION", "_G"}
  for k,v in pairs( _G ) do
    if type(v) ~= 'function' then  
       if not has(k, builtin) then 
         print(":rogue",k)
end end end end

rogue()
