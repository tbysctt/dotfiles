# echo "
#  █     █░▓█████  ██▓     ▄████▄   ▒█████   ███▄ ▄███▓▓█████ 
# ▓█░ █ ░█░▓█   ▀ ▓██▒    ▒██▀ ▀█  ▒██▒  ██▒▓██▒▀█▀ ██▒▓█   ▀ 
# ▒█░ █ ░█ ▒███   ▒██░    ▒▓█    ▄ ▒██░  ██▒▓██    ▓██░▒███   
# ░█░ █ ░█ ▒▓█  ▄ ▒██░    ▒▓▓▄ ▄██▒▒██   ██░▒██    ▒██ ▒▓█  ▄ 
# ░░██▒██▓ ░▒████▒░██████▒▒ ▓███▀ ░░ ████▓▒░▒██▒   ░██▒░▒████▒
# ░ ▓░▒ ▒  ░░ ▒░ ░░ ▒░▓  ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ░  ░░░ ▒░ ░
#   ▒ ░ ░   ░ ░  ░░ ░ ▒  ░  ░  ▒     ░ ▒ ▒░ ░  ░      ░ ░ ░  ░
#   ░   ░     ░     ░ ░   ░        ░ ░ ░ ▒  ░      ░      ░   
# " | lolcat

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting aliases)

source $ZSH/oh-my-zsh.sh

if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Running on Mac 🍺"

  # Set PATH, MANPATH, etc., for Homebrew.
  export PATH="/opt/homebrew/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Mac-specific aliases
  alias chrome-no-cors='open -na "Google Chrome" --args --disable-web-security --user-data-dir="/tmp/chrome_dev"'
else
  echo "Running on Linux 🐧"
fi

# User configuration
export VISUAL="nvim"
export EDITOR="vim"

source <(kubectl completion zsh)
source <(fzf --zsh)

# Personal binaries
export PATH="$PATH:$HOME/bin"

# Aliases
alias vim=nvim
alias k=kubectl
alias tf=terraform
alias cf=codefresh
alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias linguist='docker run -t --rm -v $(pwd):/repo:ro crazymax/linguist'

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python shit
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"
# export PATH="$HOME/.local/bin:$PATH"


# Functions

function fzcd() {
    local dir
    local search_dir="${1:-$HOME}"  # Default to $HOME if no argument is provided
    dir=$(find "$search_dir" -type d | fzf) && cd "$dir"
}

# Enable GPG signing for Git commits
export GPG_TTY=$(tty)

# Source the host-specific extras if there is a file for it
[ -f ~/.config/extra.sh ] && source ~/.config/extra.sh
