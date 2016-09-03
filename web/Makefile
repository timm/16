mds=$(shell ls *.md)

all: $(mds:.md=.html)

%.html : %.md etc/template.html etc/style.css
	@echo "$< ==> $@"
	@cd etc; luajit lust.lua ../$< > ../$@
	@git  add $@

tidy:
	tidy -q -m --indent-spaces 4 -indent \
           etc/template.html
