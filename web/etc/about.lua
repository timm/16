return {
  author="Tim Menzies",
  site="My great webpage",
  page= {},
  markup = function (text,render)
             return markdown(render(text))
           end,
  css = {
    {url= "fonts.googleapis.com/css?family=Lato:400,700"},
    {url="local.css"}
  }
}
