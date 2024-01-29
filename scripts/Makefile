SHELL := /bin/bash

tmux-sessionizer:
	mkdir -p $(HOME)/.local/bin;
ifneq ("$(wildcard $(HOME)/.local/bin/tmux-sessionizer)","")
	@echo "rm path"
	@rm $(HOME)/.local/bin/tmux-sessionizer
endif
	cp $(pwd)tmux-sessionizer $(HOME)/.local/bin/tmux-sessionizer;
	chmod +x $(HOME)/.local/bin/tmux-sessionizer;

.PHONY: tmux-sessionizer
