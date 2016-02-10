require "aaa"

Split=Object:new{crowded=4, get=last, cohen=0.1,
                 small=nil, id=1, trvial=1.05}

function Split:sdiv(t0)
  t  = sort(t, function(a,b)return self.get(a) < self.get(b))
  out= {} 
  self:sdiv1(t, self.small, out)
  return out

function Split:sdiv1(t,small,out,   cut,old) --last two init to nil
  if #t == 0 then return nil end
  local first, last = get(t[1]), get(t[#t])
  local l     = Num:new()
  local r     = Num:new():adds(map(self.get,t))
  small       = small or r.sd*self.cohen
  local range = {id=self.id, lo=first, up=last, 
                 has=t, score = r:copy()}
  local score = r.sd
  -- can I find a cut?
  if last - first > self.small then
    for i,x in ipairs(t) do
      local new = self.get(x)
      l:add(new)
      r:sub(new)
      if new ~= old then
        if l.n > self.crowded and r.n > self.crowded then
          if new - first > self.small then
            maybe = l.n/#t * l.sd + r.n/#t * r.sd
            if maybe*self.trivial < score then
              cut, score = i, maybe
      end end end end
      old = new
  end end    
  if cut then -- divide the ranage
    self:sdiv1(sub(t,1,cut), small, out)
    self:sdiv1(sub(t,cut+1), small, out)
  else -- we've found a leaf range
    add(out,range)
end end
  