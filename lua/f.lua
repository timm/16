require "nsv"
require "cols"

Fun=Object:new{
  name="",     rows   = {},
  x      = {}, y      = {}, headers= {},
  spec   = {}, more   = {}, less   = {},
  klass  = {}, nums   = {}, syms   = {}
}

function Fun:row(line,tmp)
  for j,head in ipairs(self.headers) do
    add(tmp,head:add(line[j])) 
  end 
  return tmp
end

function Fun:header(nsv,n,x)  
  nump  = nsv:has(x,"nump")
  h     = nump and Num:new{name=x} or Sym:new{name=x}
  h.pos = n
  add(self.headers, h) 
  if nsv:has(x, "more")  then add(self.more,  h) end
  if nsv:has(x, "less")  then add(self.less,  h) end
  if nsv:has(x, "klass") then add(self.klass, h) end
  if nsv:has(x, "dep")   then add(self.y,     h)
                         else add(self.x,     h) end
  if nump == true        then add(self.nums, h)
                         else add(self.syms, h)
end	end

function Fun:import(file) 
  local nsv = Nsv:new{file=file} 
  for line in nsv:rows() do   
    if #self.headers == 0 then 
      self.spec = line   
      for n,x in ipairs(line) do  
       	self:header(nsv,n,x)  end
    else   
      add(self.rows, self:row(line,{}))
end end end