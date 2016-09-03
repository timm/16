lustache = require "lustache"
markdown = require "markdown"
about    = require "about"
----------------------------------------
function render(txt) return lustache:render(txt,about) end

function slurp(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end	    
----------------------------------------
news = require "news"
about["news"]   = news
about["briefs"] = {{item = news[1].item},
                   {item = news[2].item},
                   {item = news[3].item}}
-----------------------------------------
about["main"] = arg[1] and slurp(arg[1]) or f:read("*all")

print(
  render(
    render(slurp("../etc/template.html"))))
