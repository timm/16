require "aaa"

Csv= Object:new{file      = "data.csv",
	       using     = {},
	       compilers = {},
	       chars     = {
    whitespace = "[\n\r\t ]*", -- kill all whitespace
    comment    = "#.*",        -- kill all comments
    sep        = ",",          -- field seperators
    ignorep    = "[\\?]",
    missing    = '[\\?]',
    klass      = "=",
    less       = "<",
    more       = ">",
    floatp     = "[\\$]",
    intp       = ":",
    goalp      = "[><=]",
    nump       = "[:\\$><]",
    dep        = "[=<>]"
}}

function Csv:has(txt,pat)
  return found(txt, self.chars[pat]) end

function Csv:header(cells)
  local j = 0
  for i,cell in ipairs(cells) do
    if not self:has(cell,"ignorep") then
      j = j + 1
      self.using[j] = i
      self.compilers[j] = self:has(cell, "nump")
  end end end

function Csv:row(cells)
  local out={}
  for _,j in ipairs(self.using)  do
    local cell = cells[j]
    if self.compilers[j] then cell = tonumber(cell) end
    out[#out+1]= cell
  end
  assert(#out == #self.compilers, "line wrong size")
  return out
end
    
function Csv:rows()
  io.input(self.file)
  return function()
    for line in lines(self.file,
		      self.chars["whitespace"],
		      self.chars["comment"]
                     ) do
      local cells = explode(line, self.chars["sep"]) 
      if #self.using==0 then
	self:header(cells)
      else
	return self:row(cells)
end end end end
