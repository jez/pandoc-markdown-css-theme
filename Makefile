#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# ===== Usage ================================================================
#
# make                  Prepare docs/ folder (all markdown & assets)
# make docs/index.html  Recompile just docs/index.html
#
# make watch            Start a local HTTP server and rebuild on changes
# PORT=4242 make watch  Like above, but use port 4242
#
# make clean            Delete all generated files
#
# ============================================================================

SOURCES := $(shell find src -type f -name '*.md')
TARGETS := $(patsubst src/%.md,docs/%.html,$(SOURCES))

CARGO ?= cargo
TARGET ?= x86_64-unknown-linux-musl
CARGO_TARGET_DIR ?= $(CURDIR)/target

.PHONY: all
all: docs/.nojekyll $(TARGETS)

.PHONY: clean
clean:
	rm -rf docs

.PHONY: watch
watch:
	./tools/serve.sh --watch

docs/.nojekyll: $(wildcard public/*) public/.nojekyll
	rm -vrf docs && mkdir -p docs && cp -vr public/.nojekyll public/* docs

.PHONY: docs
docs: docs/.nojekyll

# Generalized rule: how to build a .html file from each .md
# Note: you will need pandoc 2 or greater for this to work
docs/%.html: src/%.md template.html5 Makefile tools/build.sh
	tools/build.sh "$<" "$@"

### Makefile commands for rust wrapper

# Build rust wrapper
.PHONY: pandoc-pretty
pandoc-pretty: dist/pandoc-pretty

dist/pandoc-pretty: pandoc-pretty/src/main.rs pandoc-pretty/Cargo.toml template.html5 docs/css/theme.css docs/css/skylighting-solarized-theme.css pandoc-sidenote.lua
	CARGO_TARGET_DIR=$(CARGO_TARGET_DIR) $(CARGO) build --release --target $(TARGET) --manifest-path pandoc-pretty/Cargo.toml
	mkdir -p dist
	cp $(CARGO_TARGET_DIR)/$(TARGET)/release/pandoc-pretty dist/pandoc-pretty

# run tests for rust wrapper
.PHONY: test-pandoc-pretty
test-pandoc-pretty:
	CARGO_TARGET_DIR=$(CARGO_TARGET_DIR) $(CARGO) test --manifest-path pandoc-pretty/Cargo.toml --tests

### End Makefile commands for rust wrapper
