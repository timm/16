require "csv"
require "logs"

Data=Object:new{
  name="",     rows   = {},
  indep  = {}, dep    = {}, headers= {},
  spec   = {}, more   = {}, less   = {},
  klass  = {}, nums   = {}, syms   = {}
}

function Data:row(line,tmp)
  for j,head in ipairs(self.headers) do
    add(tmp,head:prep(line[j])
  end
  return tmp
end

function Data:header(csv,x)
  nump = csv:has(x,"nump")
  h    = nump and Num{name=x} or Sym{name=x}
  add(i.headers, h)
  if csv:has(h, "more")  
     then add(self.more, h)
  end
  if csv.has(h, "less")  
     then add(self.less, h)
  end	
  if csv.has(h, "klass") 
     then add(self.klass,h)  
  end
  if csv.has(h, "dep")
     then add(self.dep,  h)
     else add(self.indep,h)
  end
  if nump
     then add(self.nums, h)
     else add(self.syms. h)
  end	
end

function Data:import(file)
  local csv = Csv:new{filename=file}
  for line in csv:rows() do
    if #header==0 then
      self.spec = line
      for _,x = ipairs(line) do
 	self:header(csv,x) end
    else
      add(self.rows, self:row(line,{}))
end end end
