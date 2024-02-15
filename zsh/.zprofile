echo "user zprofile"
export XDG_CONFIG_HOME=$HOME/.config

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR="nvim"
export BROWSER="brave"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"
