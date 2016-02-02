-- everyone is prep for all

add     = table.insert
function same(x) return x end

function explode(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
 
txt = {
    whitespace = "[\n\r\t ]*", -- kill all whitespace
    comment    = "#.*",        -- kill all comments
    sep        = ",",           -- seperate fields by 'delimiter'
    ignore     = "?",
    missing    = '?',
    klass      = "=",
    less       = "<",
    more       = ">",
    float      = "$",
    int        = ":"
}

function found(x,s) print(x,s,string.find(x,s) ~= nil)
  return string.find(x,s) ~= nil end
function ignorep(x) return found(x,txt["ignore"]) end
function intp(x)    return found(x,txt["int"])    end 
function floatp(x)  return found(x,txt["float"])  end
function nump(x)    return intp(x) or floatp(x)  or
                           found(x,txt["more"])   or
                           found(x,txt["less"])   end
function goalp(x)   return found(x,txt["less"])   or
                           found(x,txt["more"])   or
                           found(x,txt["klass"])  end

function o(t,s)
  for i,x in ipairs(t) do print(s,i,"["..x.."]") end
end

function csvFile(file) 
  -- kill white space, comments, ignored columns
  -- coerce nums to nums, strings to string
  io.input(file)
  local using,preps = {},{} 
  return function()
    local line = io.read() 
    while line ~= nil do 
      line = pruneLine(line) 
      if line ~= "" then 
        local cells = explode(line, txt["sep"]) 
        if #using==0 then
          print(1)
          using,preps = header(cells)
          for i=1,#preps do print("p",preps[i]) end
        else
          print(2)
          return usable(cells,preps,using) 
        end
      end
      line = io.read()
    end
    return nil
  end
end 

function header(cells)
  local using,preps = {},{}
  for i,cell in ipairs(cells) do
    if not ignorep(cell) then 
      using[#using + 1] = i
      preps[#using] = nump(cell)  
  end end
  return using, preps
end
  
function pruneLine(str)
    str =  string.gsub(str, txt["whitespace"], "")
    return string.gsub(str, txt["comment"]   , "") 
end

function usable(cells,preps,using)
  local out = {}
  for _,j in ipairs(using)  do
    local cell = cells[j]
    print(preps[j])
    if preps[j] then cell = tonumber(cell) end
    add(out,  cell)
  end
  print(">>",#out)
  o(out,"out")
  return out
end
  
for row in csvFile("data/weather.csv") do 
  print(333333)
  print(#row, row)
  for i = 1,#row do
    print("33",i,row[i])
  end  
end