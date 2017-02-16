all: images/headerimg.png images/noresults.png images/spritesheet.png images/mobileicon.png subreddit.css

vendor/naut:
	git submodule init
	git submodule update

images:
	mkdir images

images/headerimg.png: images
	convert -size 1920x166 "xc:#34495E" $@

images/noresults.png: vendor/naut/images/noresults.png vendor/naut images
	cp $< $@

images/spritesheet.png: imagesSource/elm-color.png
	composite -compose Copy -geometry 36x36+214+55 $< -alpha set vendor/naut/images/spritesheet.png $@
	composite -compose Copy -geometry 36x36+214+103 $< $@ $@
	convert -fill 'rgb(235,170,40)' -opaque 'rgb(252,88,31)' -fuzz 10% $@ $@
	convert -fill 'rgb(131,205,79)' -opaque 'rgb(104,178,89)' -fuzz 15% $@ $@
	convert -fill 'rgb(103,181,201)' -opaque 'rgb(83,110,229)' -fuzz 15% $@ $@

images/mobileicon.png: imagesSource/elm-color.png
	convert -geometry 256x256 $< $@

subreddit.css: css.sed vendor/naut overrides.css vendor/naut/src/naut_src.css
	cat vendor/naut/src/naut_src.css overrides.css | sed -f css.sed > $@
	cleancss -o $@ $@
