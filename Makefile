FILE = slides

all:
	pandoc -t revealjs -s -o $(FILE).html $(FILE).md \
		-V center=false

clean:
	rm *.html

