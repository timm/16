Data={}

function Data.every() return "*" end
function Data.new (name)  
   local self  = {}
   local name  = name
   local nums  = {} -- indexes of indepedendent numerics
   local syms  = {} -- indexes of indepedendent symbols
   local dnums = {} -- indexes of depedendent numerics
   local dsyms = {} -- indexes of depedendent symbols
   local terms = {} -- table of terms a.k.a. attributes, features,  columns 
   local rows  = {} -- table or rows a.k.a. instaces, examples
   function self.newTerm(x) 
      table.insert(terms,x)
      table.insert(x.where,#terms)
   end
   return self
end


