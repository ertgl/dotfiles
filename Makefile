BASH := $(shell which bash || echo "bash")

DOTFILES_DIR := $(CURDIR)
DOTFILES_BIN_DIR := $(DOTFILES_DIR)/bin

.PHONY: plan
plan:
	@$(BASH) $(DOTFILES_BIN_DIR)/dotfiles_plan.sh

.PHONY: reload
reload:
	$(BASH) $(DOTFILES_BIN_DIR)/dotfiles_reload.sh

.PHONY: all
all: reload
