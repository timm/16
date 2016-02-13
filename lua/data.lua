require "csv"
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

function Data:header(csv,n,x)
  nump = csv:has(x,"nump")
  h    = nump and Num:new{name=x} or Sym:new{name=x}
  h.pos = n
  add(self.headers, h)
  print("s",#self.headers)
  if csv:has(h, "more")  then add(self.more, h) end
  if csv.has(h, "less")  then add(self.less, h) end	
  if csv.has(h, "klass") then add(self.klass,h) end
  if csv.has(h, "dep")   then add(self.dep,  h)
                         else add(self.indep,h) end
  if nump
     then add(self.nums, h)
     else add(self.syms. h)
  end	
end

function Data:import(file)
  local csv = Csv:new{file=file}
  for line in csv:rows() do
    print(22,self.headers,#self.headers)
    if #self.headers == 0 then
      print(33)
      self.spec = line
      tprint(line,"lin")
      for n,x in ipairs(line) do
 	self:header(csv,n,x) end
    else
      print(44)
      add(self.rows, self:row(line,{}))
end end end
