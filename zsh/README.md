## Requirements
- `curl`

## Installation
1. Install `zsh` according to [official installation guide](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).
2. Install `oh-my-zsh` according to [official installation guide](https://ohmyz.sh/#install).
3. `mv $HOME/.oh-my-zsh $HOME/.local/opt/oh-my-zsh`
4. Clone `dotfiles` repository and create symlink `$HOME/.config/zsh`
5. `ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv`
7. `mkdir -p $HOME/.config/zsh-exports && touch $HOME/.config/zsh-exports/custom && touch $HOME/.config/zsh-exports/path`
6. `rm $HOME/.zshrc` (optional)
