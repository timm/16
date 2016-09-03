lustache = require "lustache"
markdown = require "markdown"
new      = require "news"


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
about = {
  author="Tim Menzies",
  site="My great webpage",
  page= {},
  markup = function (text,render)
             return markdown(render(text))
           end,
  news = new,
  css = {
    {url= "fonts.googleapis.com/css?family=Lato:400,700"},
    {url="local.css"}
  }
}

print(about.news[1].when)
about["main"] = arg[1] and readAll(arg[1]) or f:read("*all")

txt1= lustache:render(readAll("template.html"),about)
txt2= lustache:render(txt1, about)

print(txt2)
