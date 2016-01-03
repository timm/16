require "lib";

function _inc2()
   local function worker ()
      local b={}
      local max=256
      math.randomseed(1)
      for i=1,10000 do inc2(b,math.random(max),math.random(max)) end
      end
   time("_inc2",worker,100)
end

function _time()
   local x 
   local function fib(n)
      if n<2 then return 1 else return fib(n-1) + fib(n-2) end
   end
   time("_time",(function () x=fib(10) end))
end 

_inc2()
_time()
