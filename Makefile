
BIN ?= rtail
PREFIX ?= /usr/local
MANPREFIX ?= $(PREFIX)/share/man/man1

$(BIN): test man

test:
	./test.sh

install:
	mkdir -p $(PREFIX)/bin $(MANPREFIX)
	cp rtail.sh $(PREFIX)/bin/$(BIN)
	cp rtail.1 $(MANPREFIX)/$(BIN).1

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
	rm -f $(MANPREFIX)/$(BIN).1

man:
	@curl -# -F page=@rtail.1.md -o rtail.1 http://mantastic.herokuapp.com
	@echo "rtail.1"
