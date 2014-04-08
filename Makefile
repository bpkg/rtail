
BIN ?= rtail
PREFIX ?= /usr/local
MANPREFIX ?= $(PREFIX)/share/man/man1

$(BIN): test man

test:
	./test.sh

install:
	install $(BIN) $(PREFIX)/bin
	install $(BIN).1 $(MANPREFIX)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
	rm -f $(MANPREFIX)/$(BIN).1

man:
	@curl -# -F page=@$(BIN).1.md -o $(BIN).1 http://mantastic.herokuapp.com
	@echo "$(BIN).1"
