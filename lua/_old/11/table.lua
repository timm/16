----------------------------------------------------------------------
-- This file is part of LURE.
--
-- LURE is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- LURE is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with LURE.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------

The["klass"]  = "!"
The["ignore"] = "?"
The["number"] = "$"

Table = Object:new{rows={},headers={},
		   nums={},syms={},depNums={},depSyms={},classes={}}

Row = Object:new{id=0,raw={}, cooked={},class=""}

function Table:cells() return self.cooked end

function Table:row(line,lines,rownum,cells)
   if (rownum == 0) then
      for n,cell in pairs(cells) do
	 self.headers[n] = self:header(n,Table.asHeader(cell))
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
   
function Table:asHeader(s)
   local out
   if string.find(s,The.number)
   then out = Sym.new(s) 
   else out = Num.new(s) 
   end
   out.name = s
   return out
end

function Table:header(n,cell)
   cell.isKlass = string.find(The.klass)
   cell.isIgnore = string.find(The.ignore)
   if cell.isKlass then
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
