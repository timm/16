require "aaa"
require "cols"

Split=Object:new{enough=nil, get=last, cohen=0.2, sanity=16,
                 small=nil, id=1, trivial=1.05}

function Split:div(t,    all,out)
  sorter = function(a,b) 
             return self.get(a) < self.get(b) end
  t   = sort(t, sorter)
  all = Num:new():adds(map(self.get,t))
  self.small  = self.small  or all.sd*self.cohen
  self.enough = self.enough or all.n/self.sanity
  out= {} 
  self:div1(t, all, out)
  return out
end

function Split:div1(t, all, out,     cut,lo,hi)  
  local first, last = self.get(t[1]), self.get(t[#t])
  local range = {id=self.id, lo=first, up=last, n=#out,
                 has=t, score = all:copy()}
  local function split(l, r, score,    old,new)
    if last - first < self.small then return nil end
    for i,x in ipairs(t) do
      new = self.get(x)
      l:add(new)
      r:sub(new)
      if new ~= old then
        if l.n >= self.enough then
          if  r.n < self.enough then return nil end
          if new - first >= self.small then
            maybe = l.n/#t * l.sd + r.n/#t * r.sd
              if maybe*self.trivial < score then
                cut,score,lo,hi = i,maybe,l:copy(),r:copy()
      end end end end
      old = new
  end end
  split(Num:new(), all, all.sd) 
  if cut then -- divide the ranage
    self:div1(sub(t,1,cut), lo, out)
    self:div1(sub(t,cut+1), hi, out)
  else -- we've found a leaf range
    add(out,range)
end end
  