SHELL := /bin/bash

all: tmux-sessionizer zsh nvim

nvim:
ifneq ("$(wildcard $(HOME)/.config/nvim)","")
	@rm -rf $(HOME)/.config/nvim
endif
	ln -s $(CURDIR) $(HOME)/.config/nvim

zsh: zshenv zshfiles

zshfiles:
ifneq ("$(wildcard $(HOME)/.config/zsh)","")
	@rm -rf $(HOME)/.config/zsh
endif
	ln -s $(CURDIR)/zsh $(HOME)/.config/zsh

zshenv:
ifneq ("$(wildcard $(HOME)/.zshenv)","")
	@rm $(HOME)/.zshenv
endif
	ln -s $(CURDIR)/zsh/.zshenv $(HOME)/.zshenv

tmux-sessionizer:
	mkdir -p $(HOME)/.local/bin;
ifneq ("$(wildcard $(HOME)/.local/bin/tmux-sessionizer)","")
	@echo "rm path"
	@rm $(HOME)/.local/bin/tmux-sessionizer
endif
	cp $(CURDIR)/scripts/tmux-sessionizer $(HOME)/.local/bin/tmux-sessionizer;
	chmod +x $(HOME)/.local/bin/tmux-sessionizer;

.PHONY: nvim zsh tmux-sessionizer
