-- config
The = {}
The["klass"]  = "!"
The["ignore"] = "?"
The["number"] = "$"
inf  = 10^32
ning = -1*inf

-- one liners
fmt   = string.format

-- list
function member(x,lst)
  for y in items(lst) do
    if x== y then return true end end
  return false
end

-- tests
function rogue(x) 
  local builtin = { "true","math","package","table",
		    "coroutine","os","io","bit32",
		    "string","arg","debug",
		    "_VERSION","_G"}
  for k,v in pairs( _G ) do
    if type(v) ~= 'function' then  
       if not member(k, builtin) then 
         print(":rogue",k) end end end end
     
do
  local y,n = 0,0
  local function report() 
    print(fmt(":pass %s :fail %s :percentPass %s%%",
              y,n,p(y/(0.001+y+n))))
    rogue() end
  local function test(s,x) 
    print("# test:",s) 
    local passed,err = pcall(x) 
    if passed then y = y + 1 else
       n = n + 1
       print("Fails:",err) end end 
  local function tests(t)
    for s,x in pairs(t) do test(s,x) end end 
  function ok(t) 
    if empty(t) then report() else tests(t) end end
end 

-- print
function o(data) print(oo(data)) end

function oo(data, indent)  -- anything to a string
   if(indent == nil) then indent = 0 end 
   local str,pad = "",rep(indent)
   if type(data) ~= "table" then 
      return pad .. tostring(data)
   end
   for i, v in pairs(data) do 
      str = str .. pad .. i .. ": "
      if(type(v) == "table") then 
	 str = str .." \n"  .. oo(v,indent+2)
      else 
	 str = str .. oo(v,0) .. "\n"
   end end
   return str
end

-- OO
Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

-- Table

Range={col= nil,lo= inf, up= ninf}
Table = Object:new{  rows={}, headers={},
		     indep= {nums={}, syms={}},
		     dep  = {nums={}, syms={}},
		     nums={},syms={},classes={}}

Row = Object:new{id=0,raw={}, cooked={}}

function Table:row(line,lines,rownum,cells)
   if (rownum == 0) then
      for n,cell in pairs(cells) do
	self.headers[n] = self:header(n,
		            Table.asHeader(cell))
      end
   else
      local row=Row:new{id=rownum}
      for n,cell in cells do
	 local head = self.headers[n]
	 local data  = head.compile(cell)
	 if head.isKlass then
	    row.class = row.class .. tostring(cell)
	 end
      end
      inc1(classes,row.class)
      row.raw[n] = head.add(cell)
   end
   table.insert(rows,row)
end end

