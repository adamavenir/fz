PREFIX ?= /usr/local

install:
	install -d $(PREFIX)/bin
	install -m 755 fz $(PREFIX)/bin/fz

uninstall:
	rm -f $(PREFIX)/bin/fz
