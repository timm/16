require "nsv"
require "cols"

Data=Object:new{
  name="",     rows   = {},
  indep  = {}, dep    = {}, headers= {},
  spec   = {}, more   = {}, less   = {},
  klass  = {}, nums   = {}, syms   = {}
}

function Data:row(line,tmp)
  for j,head in ipairs(self.headers) do
    add(tmp,head:prep(line[j]))
  end
  return tmp
end

function Data:header(Nsv,n,x)
  nump = Nsv:has(x,"nump")
  h    = nump and Num:new{name=x} or Sym:new{name=x}
  h.pos = n
  add(self.headers, h)
  print("X",x)
  if Nsv:has(x, "more")  then add(self.more, h) end
  if Nsv.has(x, "less")  then add(self.less, h) end	
  if Nsv.has(x, "klass") then add(self.klass,h) end
  if Nsv.has(x, "dep")   then add(self.dep,  h)
                         else add(self.indep,h) end
  if nump
     then add(self.nums, h)
     else add(self.syms, h)
end	end

function Data:import(file)
  local Nsv = Nsv:new{file=file}
  for line in Nsv:rows() do
    print(22,self.headers,#self.headers,line)
    if #self.headers == 0 then
      print(33)
      self.spec = line
      tprint(line,"lin")
      for n,x in ipairs(line) do
        print(">>>>",n,x)
       	self:header(Nsv,n,x) 
       	print(n, #self.headers)
      end
    else
      print(44)
      add(self.rows, self:row(line,{}))
end end end
