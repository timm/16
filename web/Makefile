mds=$(shell ls *.md)

all: $(mds:.md=.html)

title=gawk 'gsub(/^#+ /,"") { print $0; exit}'#

%.html : %.md #etc/template.html etc/about.html
	@echo "$< ==> $@"
	@cd etc; /usr/local/bin/lua lust.lua ../$< > ../$@
	@git  add $@

tidy:
	tidy -q -m --indent-spaces 4 -indent \
           etc/template.html
