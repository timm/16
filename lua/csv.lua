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
  for i,x in ipairs(cells) do
    if not self:has(x,"ignorep") then
      j = j + 1
      self.using[j]     = i
      self.compilers[j] = self:has(x, "nump") 
  end end end

function Csv:row(cells)
  local out={}
  for _,j in ipairs(self.using)  do
    local x = cells[j]
    if self.compilers[j] then x = tonumber(x) end
    out[#out+1]= x
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