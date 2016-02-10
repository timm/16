require "aaa"

Split=Object:new{crowded=4, get=last, cohen=0.1,
                 small=nil, splits={},id=1,
                 sorter= function (a,b) 
                          return get(a) < get(b) end}

function Split:sdiv(t0)
  table.sort(t,sorter)
  if self.small == nil then
    local all = Num:new():adds(t)
    self.small = all.sd*self.cohen  end
  return self:sdiv1(t)

function Split:sdiv1(t)
  local l = Num:new()
  local r = Num:new():adds(map(self.get,t))
  local about = {mu=r.mu, n=r.n, score=r.sd}
  local first = get(t[1])
  local cut, old, about, score,n0 = nil, nil, nil, r.sd, r.n
  -- look for cut
  for i,tmp in ipairs(t) do
    new = self.get(tmp)
    l.add(new)
    r.sub(new)
    if new ~= old then
      if l.n > self.crowded and l.n > self.crowded then
        if new - first > self.small then
          maybe = l.n/n0 * l.sd + r.n/n0 * r.sd
          if maybe < score then
            cut, score = i, maybe
    end end end end
    old = new
  end
  -- use the results of the looking
  if cut then
    self:sdiv1(sub(t,1,cut))
    self:sdiv1(sub(t,cut+1))
  else
    add(self.splits{id= self.id, lo= first, up= last(get(t)),
                    has= this, about= about})
  end
end
  