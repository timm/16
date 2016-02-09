require "aaa"
require "cols"

Split=Object:new{crowded=4, cohen=0.1, fayyad=false, small=4}

function Split:crowded(n) 
  return n > self.crowded end

function Split:smallEffect(t,num) 
  return Num:new():adds(t).sd*self.cohen end 

function Split:sdiv1(t,x)
  return self:sdiv{t=t,num1=x,num2=x}
  
function Split:sdiv(o)
   o.num1
end