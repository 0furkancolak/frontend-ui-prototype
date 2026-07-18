SHELL := /bin/bash

.PHONY: help validate install install-claude install-codex reinstall uninstall clean package

help:
	@printf '%s\n' \
	  'make validate        Validate the skill package' \
	  'make install         Install for Claude Code and Codex' \
	  'make install-claude  Install only for Claude Code' \
	  'make install-codex   Install only for Codex' \
	  'make reinstall       Clean reinstall for both agents' \
	  'make uninstall       Remove installed symlinks' \
	  'make clean           Remove generated archives/temp files' \
	  'make package         Build ../frontend-ui-prototype.zip'

validate:
	@./scripts/validate.sh

install: validate
	@./scripts/install.sh

install-claude: validate
	@./scripts/install.sh --claude-only

install-codex: validate
	@./scripts/install.sh --codex-only

reinstall: validate
	@./scripts/uninstall.sh || true
	@./scripts/install.sh --force

uninstall:
	@./scripts/uninstall.sh

clean:
	@rm -f ../frontend-ui-prototype.zip
	@rm -rf .tmp
	@find . -name '.DS_Store' -delete
	@echo "Skill package cleaned."

package: clean validate
	@cd .. && zip -qr frontend-ui-prototype.zip frontend-ui-prototype \
	  -x 'frontend-ui-prototype/.git/*' \
	  -x 'frontend-ui-prototype/.tmp/*'
	@echo "Created ../frontend-ui-prototype.zip"
