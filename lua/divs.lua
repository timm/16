require "aaa"
require "cols"

Split=Object:new{enough=nil, get=last, cohen=0.2, sanity=16,
                 small=nil, id=1, trivial=1.05}

function Split:div(t)
  sorter = function(a,b) 
             return self.get(a) < self.get(b) end
  t  = sort(t, sorter)
  out= {} 
  self:div1(t, self.small, out)
  return out
end

function Split:div1(t,small,out,   _cut,_old)  
  if #t == 0 then return nil end
  local first, last = self.get(t[1]), self.get(t[#t])
  local l     = Num:new()
  local r     = Num:new():adds(map(self.get,t))
  self.small  = self.small or  r.sd*self.cohen
  self.enough = self.enough or #t/self.sanity
  local range = {id=self.id, lo=first, up=last, n=#out,
                 has=t, score = r:copy()}
  local score = r.sd
  -- can I find a cut?
  if last - first > self.small then
    for i,x in ipairs(t) do
      local new = self.get(x)
      l:add(new)
      r:sub(new)
      if new ~= _old then
        if l.n >= self.enough and r.n >= self.enough then
          if new - first > self.small then
            maybe = l.n/#t * l.sd + r.n/#t * r.sd
            if maybe*self.trivial < score then
              _cut, score = i, maybe
      end end end end
      _old = new
  end end    
  if _cut then -- divide the ranage
    self:div1(sub(t,1,_cut), small, out)
    self:div1(sub(t,_cut+1), small, out)
  else -- we've found a leaf range
    add(out,range)
    print(range.n, r3(range.lo), r3(range.up), #range.has)
end end
  