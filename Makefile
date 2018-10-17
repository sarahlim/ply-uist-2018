FILE = index

all:
	pandoc -t revealjs -s -o $(FILE).html $(FILE).md \
		--slide-level=2 \
		--filter pandoc-citeproc \
		# -V center=false \

clean:
	rm *.html

