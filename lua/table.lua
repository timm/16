find    = string.find
add     = table.insert
function same(x) return x end

function explode(str,div)
    div = div or "\S+"
    local out = {}
    for cell in string.gmatch(str,div) do   
        add(out,cell) end
    return out
end

function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

function shown(...) print(show1(arg)) end
function show(...)  return show1(arg)  end 

function show1(arg)
   local str=""
   for i = 1,arg["n"] do
      str = str..i..":"..tostring(arg[i]).."; " end 
   return str
end

function o(x) print(oo(x)) end

function oo(data, indent) -- convert anything to a string
   if not indent then indent = 0 end 
   local str,pad = "",rep(indent)
   if type(data) ~= "table" then 
      return pad..tostring(data) end
   for i, v in pairs(data) do 
      str = str..pad..i..": "
      if   type(v) == "table"  
	    then str = str.." \n"..oo(v,indent+2)
      else str = str..oo(v,0).."\n"
   end end
   return str
end

txt = {
    whitespace = "[\n\r\t ]*", -- kill all whitespace
    comment    = "#.*",        -- kill all comments
    delimiter  = ",",           -- seperate fields by 'delimiter'
    ignore     = "?",
    missing    = '?',
    klass      = "=",
    less       = "<",
    more       = ">",
    float      = "$",
    int        = ":"
}

function ignorep(x) return find(x,txt["ignore"]) end
function intp(x)    return find(x,txt["int"])    end 
function floatp(x)  return find(x,txt["float"])  end
function nump(x)    return intp(x) or floatp(x)  or
                           find(x,txt["more"])   or
                           find(x,txt["less"])   end
function goalp(x)   return find(x,txt["less"])   or
                           find(x,txt["more"])   or
                           find(x,txt["klass"])  end

function fields() 
  -- kill white space, comments, ignored columns
  -- coerce nums to nums, strings to string
  local first,use,compile = true,{},{}
  local function worker(s)
    local s        = s:gsub("%s+",""):gsub(txt["comment"],"")
    local all      = explode(s,txt["deliminter"])
    local cell,out = nil,{}
    if first then
      for i = 1,#all do
        cell       = all[i]
        compile[i] = nump(cell) and tonumber or tostring
        if not ignorep(cell) then
          add(use,i)
    end end end
    for i = 1,#use do
      cell = all[use[i]]
      cell = first and cell or compile[i](cell)
      add(out, cell)
    first=false
    return out
  return worker
end

NumSym = Object:new(nums={}, syms={}}
Table  = Object:new{rows   = {},
                    header = nil,
                    all    = {},
                    dep    = NumSum:new(),
                    indep  = NumSym:new()} 
                  
function Table:header1(n,fields)  
   self.header=fields
   for field in string.gmatch(fields, '([^,]+)') do
     
   if klassp(txt) then
     add(self.he
      self.class = self.class .. self.name
   end
   if string.find(The.number) then
      if cell.isKlass 
      then table.insert(self.depNums,n) 
      else table.insert(self.nums,   n) 
      end
   else
      if cell.isKlass 
      then table.insert(self.depSyms,n)
      else table.insert(self.syms,   n) 
end end end

do
  
  local function headers(
end

table{
   headers={S"sunny", N"temp", N"humidity", S"windy"
   data=[[
  sunny,85,85,FALSE,no
  sunny,80,90,TRUE,no
  overcast,83,86,FALSE,yes
  rainy,70,96,FALSE,yes
  rainy,68,80,FALSE,yes
  rainy,65,70,TRUE,no
  overcast,64,65,TRUE,yes
  sunny,72,95,FALSE,no
  sunny,69,70,FALSE,yes
  rainy,75,80,FALSE,yes
  sunny,75,70,TRUE,yes
  overcast,72,90,TRUE,yes
  overcast,81,75,FALSE,yes
  rainy,71,91,TRUE,no]]}