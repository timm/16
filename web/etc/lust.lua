lustache = require "lustache"
markdown = require "markdown"
about    = require "about"

function readAll(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

function show(about,txt)
  print(lustache:render(txt, about))
end			    

----------------------------------------
news= require "news"
about["news"]   = news
about["briefs"] = {{item = news[1].item},
                   {item = news[2].item},
                   {item = news[3].item}}
about["main"] = arg[1] and readAll(arg[1]) or f:read("*all")

txt1= lustache:render(readAll("../etc/template.html"),about)
txt2= lustache:render(txt1, about)

print(txt1)
