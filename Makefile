PREFIX ?= /usr/local

install:
	install -d $(PREFIX)/bin
	install -m 755 fz $(PREFIX)/bin/fz

uninstall:
	rm -f $(PREFIX)/bin/fz

# Get current version, bump minor, tag and push
release:
	@current=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
	major=$$(echo $$current | sed 's/v//' | cut -d. -f1); \
	minor=$$(echo $$current | sed 's/v//' | cut -d. -f2); \
	patch=$$(echo $$current | sed 's/v//' | cut -d. -f3); \
	new_minor=$$((minor + 1)); \
	new_version="v$$major.$$new_minor.0"; \
	echo "$$current -> $$new_version"; \
	git tag $$new_version && \
	git push origin main --tags && \
	echo "Tagged and pushed $$new_version" && \
	echo "" && \
	echo "Next: update homebrew formula with:" && \
	echo "  curl -sL https://github.com/adamavenir/fz/archive/refs/tags/$$new_version.tar.gz | shasum -a 256"
