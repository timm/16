--[[ 
Lua is a "batteries not included" language that does
arrive, off the shelf, with numerous large and
intricate libraries.

Some people prefer Python since it arrives with
those large libraries. Other people prefer Lua since
it doesn't.

Every Lua progarmmer has their own little library of
tricks that contains all their common tricks for the
"batteries not included" in standard Lua. 

Share and enjoy!
--]]

-- Number stuff -----------------------

r = math.random

function rseed(seed)
  math.randomseed(seed and seed or 1)
end

function round(x)
  return math.floor(x + 0.5)
end

function rn(digits,x)
  local shift = 10 ^ digits
  return math.floor( x*shift + 0.5 ) / shift
end

function rns(digits,t)
  local out = {}
  for _,x in ipairs(t) do
    add(out, rn(digits,x))
  end
  return out
end

-- Table stuff ------------------------
add = table.insert

function first(t) return t[ 1] end
function last(t)  return t[#t] end

function sort(t)
  table.sort(t)
  return t
end

function o(t,s)
  for i,x in ipairs(t) do print(s,i,"["..x.."]") end
end

function asTable(x)
  return type(x) == "table" and x or {x}
end 

function items(t)
  local i,max=0,#t
  return function ()
    if i< max then
      i = i + 1
      return t[i]
end end end

function member(x,t)
  for y in items(t) do
    if x== y then return true end end
  return false
end



-- String stuff --------------------
function len(x)
  return string.len(x==nil and "" or x) end

function found(x,pat)
  return string.find(x,pat) ~= nil end

function lastchar(str)
  return string.sub(str, -1, -1) end

function explode(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t,i = {},1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function implode(t, sep)
  sep = sep and sep or ","
  local str = ""
  for i,x in ipairs(t) do
    sep1 = i == 1 and "" or sep
    str = str..x.. sep
  end
  return str
end

function s2t(str)
  local out = {}
  for i = 1,#str do
    local c = string.sub(str,i,i) 
    add(out, c)
  end
  return out
end 
  

-- OO stuff --------------------
Object={}

function Object:new(o)
   o = o or {}
   setmetatable(o,self)
   self.__index = self
   return o
end

-- Meta stuff -------------------------
function same(x) return x end

function rogue(x) 
  local builtin = { "true","math","package","table","coroutine",
       "os","io","bit32","string","arg","debug","_VERSION","_G"}
  for k,v in pairs( _G ) do
    if type(v) ~= 'function' then  
       if not member(k, builtin) then 
         print(":globals",k) end end end end

-- Test engine stuff -----------------------
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

-- File stuff ------------------------

function lines(white,comment)
  -- kill white space, join comma-ending files
  -- to next line, skip empty lines
  -- has to precluded with io.input(file)
  return function()  
    local pre, line = "", io.read()
    while line ~= nil do
      line = line:gsub(white,""):gsub(comment,"")
      if line ~= "" then
	if lastchar(line) == "," then
	  pre  = pre .. line
        else
	  line =  pre .. line
	  pre  = ""
	  return line
      end end
      line = io.read()
    end
    if len(pre) > 0 then return pre end
end end
