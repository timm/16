Reader={}

function Reader.data(name,rows)
   local out = Data.new(name)
   for i,row in ipairs(rows) do
      if i == 1
      then Reader.headerRow(out,row)
      else Reader.dataRow(out,row)
      end
   end
   for row in values(data.rows) do
      for pos in values(data.nums) do
	 row[pos] = data.terms[pos].normalize(row[pos])
      end
   end
   -- fille in the binds cdf
   return out
end

function Reader.headerRow(data,row) 
   local term
   local function klassp(cell) return string.find(cell,"!") end
   local function nump(cell)   return string.find(cell,"$") end
   for i,cell in iparis(row) do
      if   nump(cell)
      then term=Num.new(cell,data)
      else term=Sym.new(cell,data)
      end
      term.klassp = klassp(cell)
      data.newTerm(term)
   end
end

function Reader.dataRow(data,row)
   table.insert(data.rows,row)
   local function klass(row)
      local out = ""
      local sep = ""
      for i,v in ipairs(dsyms) do 
	 out = out .. sep .. row[v]; sep = ","
      end
      return out
   end
   local what = klass(row)
   for i,cell in ipairs(row) do
      data.terms[i].add(cell,klass)
   end
end
