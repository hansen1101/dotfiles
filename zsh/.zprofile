echo "user zprofile"
export XDG_CONFIG_HOME=$HOME/.config

# Add `~/.local/bin` to path
export PATH="$PATH:$HOME/.local/bin"

export EDITOR="nvim"
export BROWSER="brave"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"
