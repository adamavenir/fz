PREFIX ?= /usr/local

install:
	install -d $(PREFIX)/bin
	install -m 755 fz $(PREFIX)/bin/fz

uninstall:
	rm -f $(PREFIX)/bin/fz

HOMEBREW_TAP := $(HOME)/dev/homebrew-tap
FORMULA := $(HOMEBREW_TAP)/Formula/fz.rb

# Get current version, bump minor, tag, push, and update homebrew
release:
	@current=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
	major=$$(echo $$current | sed 's/v//' | cut -d. -f1); \
	minor=$$(echo $$current | sed 's/v//' | cut -d. -f2); \
	new_minor=$$((minor + 1)); \
	new_version="v$$major.$$new_minor.0"; \
	echo "$$current -> $$new_version"; \
	git tag $$new_version && \
	git push origin main --tags && \
	echo "Tagged and pushed $$new_version"; \
	echo "Updating homebrew formula..."; \
	sha=$$(curl -sL https://github.com/adamavenir/fz/archive/refs/tags/$$new_version.tar.gz | shasum -a 256 | cut -d' ' -f1); \
	sed -i '' "s|/tags/v[0-9]*\.[0-9]*\.[0-9]*\.tar\.gz|/tags/$$new_version.tar.gz|" $(FORMULA); \
	sed -i '' "s/sha256 \".*\"/sha256 \"$$sha\"/" $(FORMULA); \
	cd $(HOMEBREW_TAP) && git add Formula/fz.rb && git commit -m "fz $$new_version" && git push; \
	echo "Done! Released $$new_version"
