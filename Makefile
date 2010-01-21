prefix=/usr/local

all: doc

doc/git-publish.1: doc/git-publish.1.txt
	a2x -f manpage -L doc/git-publish.1.txt

doc/git-publish.1.html: doc/git-publish.1.txt
	asciidoc doc/git-publish.1.txt

doc: doc/git-publish.1 doc/git-publish.1.html

clean:
	rm -f doc/git-publish.1 doc/git-publish.1.html

install: git-publish doc/git-publish.1 doc/git-publish.1.html
	install -d -m 0755 $(prefix)/bin
	install -m 0755 git-publish $(prefix)/bin
	install -d -m 0755 $(prefix)/share/man/man1
	install -m 0644 doc/git-publish.1 $(prefix)/share/man/man1/
	install -m 0644 doc/git-publish.1.html $(prefix)/share/man/man1/

