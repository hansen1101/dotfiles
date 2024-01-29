SHELL := /bin/bash

zsh: zshenv zshfiles

zshenv:
ifneq ("$(wildcard $(HOME)/.config/zsh)","")
	@rm -rf $(HOME)/.config/zsh
endif
	ln -s $(CURDIR)/zsh $(HOME)/.config/zsh

zshfiles:
ifneq ("$(wildcard $(HOME)/.zshenv)","")
	@rm $(HOME)/.zshenv
endif
	ln -s $(CURDIR)/.zshenv $(HOME)/.zshenv

tmux-sessionizer:
	mkdir -p $(HOME)/.local/bin;
ifneq ("$(wildcard $(HOME)/.local/bin/tmux-sessionizer)","")
	@echo "rm path"
	@rm $(HOME)/.local/bin/tmux-sessionizer
endif
	cp $(CURDIR)/scripts/tmux-sessionizer $(HOME)/.local/bin/tmux-sessionizer;
	chmod +x $(HOME)/.local/bin/tmux-sessionizer;

.PHONY: zsh tmux-sessionizer
