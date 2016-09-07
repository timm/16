lustache = require "lustache"
markdown = require "markdown"
about    = require "about"
----------------------------------------
function render(txt) return lustache:render(txt,about) end

function title(str)    
    for s in str:gmatch"[^\n]+" do
      if string.sub(s,1,2) == "# " then
        return string.sub(s,3)
end end end

function slurp(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end	    
----------------------------------------
news = require "news"
about.news   = news
about.briefs =    {
  {item = news[1].item},
  {item = news[2].item},
  {item = news[3].item},
    {item = news[4].item},
  {item = news[5].item},
  {item = news[6].item},
    {item = news[7].item},
  {item = news[8].item},
  {item = news[9].item}
}
-----------------------------------------
raw = arg[1] and slurp(arg[1]) or f:read("*all")

about.title = title(raw)

about.main = markdown(raw)

print(render(render(slurp("../etc/template.html"))))
