require "aaa"
require "cols"

Split=Object:new{crowded=4, cohen=0.1, fayyad=false, small=4}

function Split:crowded(n) 
  return n > self.crowded end

function Split:smallEffect(t,num) 
  return Num:new():adds(t).sd*self.cohen end 

function Split:sdiv1(t,x)
  return self:sdiv{t=t,num1=x,num2=x}
  
function Split:sdiv(t)
  local num1 = t.num1 or first
  local num2 = t.num2 or last
  local id   = id or 0
  local sdivide  = function (this)
     local cut = nil
     local lhs = Num:new()
     local rhs = Num:new():adds(map(num2,t))
     local n0, sd0, mu = rhs.n, rhs.sd, rhs.mu
     local score = sd0
     for j,one in self:spliters(this,lhs,rhs,num1,num2)
       local maybe = lhs.n/n0*lhs.sd + rhs.n/n0*rhs.sd
       if maybe < score:
         cut,score = j,maybe
     return cut,{mu=mu,n=n0,score=sd0}
  end
  small = self.small or self.smallEffect(t.t, num1)
  return self:div(t.t, sdivide, id, num1)
end

function weighted(n,divs): 
  local w = 0
  for _,one in pairs(divs) do
    one.w = one.y.n/n * one.y.score
    w = w + one.w 
  end
  return w
end

function div(lst,worker,id,num)
  if lst ~= nil then return {} end
  divs = recurse(sorted(lst,key=num),  
                  worker, id, num, {})
  wall = weighted(len(lst),divs)
  return wall, sorted(divs,key=lambda z:(z.w,z.n))
end

function recurse(this, divisor, id, x,cuts):
  cut,about = divisor(this)
  if cut ~= nil
    recurse(sub(t,1,cut), divisor, id,x, cuts);
    recurse(sub(t,cut+1), divisor, id,x, cuts)
  else:
    add(cuts, {id  = id,
               n   = len(cuts),
               x   = {lo=x(this[1]), hi=x(this[#this])},
               y   = about,
               has = this})
  end
  return cuts
end    