require "csv"

Log = Object:new{name= "",
		 pass= "[\\?]",
                 n   = 0}
Sym = Log:new{counts = {},
	        mode = nil,
	        most = 0}
Num = Log:new{    up = -1*10^32,
	          lo = 10^32,
	           n = 0,
	          mu = 0,
                  m2 = 0,
                  sd = 0}
Logs = Object:new{has= {}}

function Log:__mul(t)
  for _,x in pairs(t) do
    self + x
end end

-- Log  --------------------------------
function Log:__add(x)
  if x ~= self.ignore then
    i.n = i.n + 1
    self:add(x)
end end

function Num:add(x)
  local delta = x - self.mu
  self.mu = self.mu + delta / self.n
  self.m2 = self.m2 + delta * (x - self.mu)
  if self.n > 1 then
    self.sd = (self.m2/(self.n - 1))^0.5
end end

function Sym:add(x)
  local old = self.counts[x]
  old = old == nil and 0 or old
  local new = self.counts[x] = old + 1
  if new > self.most then
    self.mode, self.most = x,new
end end

-- Logs --------------------------------
function Logs:header(t)
  c = Csv:new()
  for _,one in ipairs(t) do
    what = c:has(x,"nump") and Num or Sym
    add(self.has, what{name=what})
end end

function Logs:__add(t)
  for i,one in ipairs(self.has) do
    one + t[i]
end end
