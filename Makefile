FILE = slides

all:
	pandoc -t revealjs -s -o $(FILE).html $(FILE).md \
		-V center=false \
		-V revealjs-url=http://lab.hakim.se/reveal-js

clean:
	rm *.html

