require "aaa"

print(len("1234"))

Txt = {
    whitespace = "[\n\r\t ]*", -- kill all whitespace
    comment    = "#.*",        -- kill all comments
    sep        = ",",           -- seperate fields by 'delimiter'
    ignorep    = "[\\?]",
    missing    = '[\\?]',
    klass      = "=",
    less       = "<",
    more       = ">",
    floatp     = "[\\$]",
    intp       = ":",
    goalp      = "[><=]",
    nump       = "[:\\$><]"
}

do
  -- read csv fileskill white space, comments, ignored columns
  -- coerce nums to nums, strings to string
  
  local function pruneLine(str)
    if str == nil then
      return str
    else
      return str:gsub(Txt["whitespace"], "")
	        :gsub(Txt["comment"]   , "")
  end end
 
  local function header(cells,using,compilers)
    for i,cell in ipairs(cells) do
      if not found(cell,Txt["ignorep"]) then 
	using[#using + 1] = i
	compilers[#using] = found(cell,Txt["nump"])
  end end end

  local function row(cells,compilers,using,out)
    for j in items(using)  do
      local cell = cells[j]
      if compilers[j] then cell = tonumber(cell) end
      out[#out+1]= cell
    end
    return out
  end

  function line1(file)
    io.input(file)
    local line = pruneLine(io.read())
    local pre  = ""
    return function()
      while line ~= nil do
        if lastchar(line) == "," then
	  pre = pre .. line
        else
	  local out = pre .. line
	  pre  = ""
	  return out
	end
	line = pruneLine(io.read())
      end
      if len(pre) > 0 then return pre end
    end
  end
    
  function csvFile(file) 
    io.input(file)
    local using,compilers = {},{} 
    return function()
      local line= pruneLine(io.read())
      while line ~= nil do 
        if line ~= "" then 
          local cells = explode(line, Txt["sep"]) 
	  if #using==0 then
	    header(cells,using,compilers)
	  else
	    return row(cells,compilers,using,{})
	end end
	line = pruneLine(io.read())
  end end end end
