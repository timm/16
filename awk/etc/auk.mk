Tmp=$(HOME)/tmp/tawk
Auk=etc
Awks=$(shell ls *.awk)
Files=$(Tmp)/$(subst .awk ,.awk $(Tmp)/,$(Awks))

fred:
	echo $(Files)

all : dirs files

files: auk $(Tmp)/prep.sed $(Files)

dirs :
	mkdir -p $(Tmp)

auk : $(Auk)/auk.mk
	echo "AWKPATH='$(Tmp)' gawk --dump-variables='$(Tmp)/awkvars.out' --profile='$(Tmp)/awkprof.out' " > $@
	chmod +x $@

$(Tmp)/prep.sed : $(Auk)/h2sed.awk $(Awks)
	cat $(Awks) | grep '^#_ ' | gawk  -f $(Auk)/h2sed.awk  > $@

$(Tmp)/%.awk : %.awk $(Tmp)/prep.sed
	sed -f $(Tmp)/prep.sed $< > $@

vars :
	if  [ -f "$(Tmp)/awkvars.out" ] \
	then                             \
	  egrep -v '[A-Z][A-Z]' $(Tmp)/awkvars.out | sed 's/^/W> rogue local: /' ; \
	fi

