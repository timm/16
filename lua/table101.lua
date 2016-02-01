find    = string.find
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

function ignorep(x) return find(x,txt["ignore"]) end
function intp(x)    return find(x,txt["int"])    end 
function floatp(x)  return find(x,txt["float"])  end
function nump(x)    return intp(x) or floatp(x)  or
                           find(x,txt["more"])   or
                           find(x,txt["less"])   end
function goalp(x)   return find(x,txt["less"])   or
                           find(x,txt["more"])   or
                           find(x,txt["klass"])  end

function rows(file) 
  -- kill white space, comments, ignored columns
  -- coerce nums to nums, strings to string
  io.input(file)
  local line=io.read()
  local first,use,numps = true,{},{}
  return function()
    while line ~= nil do 
      line = line:gsub("(%s+|\n)",""):gsub(txt["comment"],"")
      local cells = explode(line,txt["sep"])
      line = io.read()
      local out={}
      if line ~= "" then
         if first then
           for i = 1,#cells do
             local cell = cells[i]
             if not ignorep(cell) then
               print("using",i)
               use[#use+1] = i
               numps[#use] = nump(cell) 
             end 
           end 
         end
         for i = 1,#use do
           local j = use[i]
           print("!!",i,use[i],cells[j])
           local cell = cells[j]
           if not first and numps[j] then
              cell = tonumber(cell)
           end
           out[#out+1] = cell
         end
         first=false
         for k,v in ipairs(out) do
           print("kv",k,v)
         end
      end
      return out
    end
    return nil
  end
end

for row in rows("data/weather.csv") do
  print("")
  for k,v in ipairs(row) do
    print("33",k,v)
  end  
end