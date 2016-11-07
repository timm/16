Make = $(MAKE) --no-print-directory #
ok=$(shell *ok.py)

typo:  ready 
	@- git status
	@- git commit -am "saving"
	@- git push origin master

commit:  ready 
	@- git status
	@- git commit -a 
	@- git push origin master

update:; @- git pull origin master
status:; @- git status

ready: gitting  zips

zips0: 
	cd lua; rm fun.zip; zip fun.zip README.md

zips:
	@- zip -ur lua/fun.zip  lua -x *.git* -x *.zip* -x _\* -x lua/_*/\* -x \#*


gitting:
	@git config --global credential.helper cache
	@git config credential.helper 'cache --timeout=3600'

your:
	@git config --global user.name "Your name"
	@git config --global user.email your@email.address

timm:
	@git config --global user.name "Tim Menzies"
	@git config --global user.email tim.menzies@gmail.com

ok:
	$(foreach f,$(ok),python  $f;)


