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

setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# Initialise the Zsh completion system, enabling tab completion for commands, arguments, filenames, and repository elements like Git branches and remotes.
autoload -Uz compinit && compinit

# Add version control support
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst # Enable prompt substitution for variable expansion
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '⎇ %b %u%c' # %u = unstaged changes, %c = staged changes, %b = branch name
zstyle ':vcs_info:git:*' actionformats '⎇ %b (%a) %u%c' # %a = action git is currently performing ("merge" or "rebase")
zstyle ':vcs_info:git:*' unstagedstr '* '
zstyle ':vcs_info:git:*' stagedstr '+ '
zstyle ':vcs_info:*:*' check-for-changes true # This enables %u and %c (unstaged/staged changes) to work, but can be slow on large repos

# Explicitly set keybind mode to emacs because ZSH will use vi mode when the EDITOR env var includes "vi"
bindkey -e
KEYMAP_VALUE=""

function zle-line-init {
  if [[ ${KEYMAP} == vicmd ]]; then
    KEYMAP_VALUE="%F{red}[vicmd]%f"
  else
    KEYMAP_VALUE=""
  fi
  zle reset-prompt
}

function zle-keymap-select {
  KEYMAP_VALUE=$KEYMAP
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    KEYMAP_VALUE="%F{red}[vicmd]%f"
  else
    KEYMAP_VALUE=""
  fi
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


# %n@%m = user@host
PROMPT='%F{blue}%1~%f ${vcs_info_msg_0_}%# '
RPROMPT='${KEYMAP_VALUE} %(?.%F{green}✓.%F{red}×)%f'


# Add personal local binaries to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin/opencode:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# User configuration
export VISUAL="nvim"
export EDITOR="vim"


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

if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi


# Aliases
alias vim=nvim
alias k=kubectl
alias tf=terraform
alias cf=codefresh

alias ssh="TERM=xterm-256color ssh" # Usually remote machines don't understand the "alacritty" TERM type.
alias diff='diff --color=always'

alias l="ls -al --color=auto"
alias ga="git add"
alias gc="git commit"
alias gst="git status"
alias gsw="git switch"
alias glo="git log --oneline --decorate --color --graph"

alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias linguist='docker run -t --rm -v $(pwd):/repo:ro crazymax/linguist'

alias dots="vim $HOME/dotfiles"

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

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  function fzcd() {
    local dir
    local search_dir="${1:-$HOME}"  # Default to $HOME if no argument is provided
    dir=$(find "$search_dir" -type d | fzf) && cd "$dir"
  }
fi

# Enable GPG signing for Git commits
export GPG_TTY=$(tty)

# Source the host-specific extras if there is a file for it
[ -f ~/.zsh/extra.zsh ] && source ~/.zsh/extra.zsh

# Niceties for interactive shell experience, making it similar to Fish shell.
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Must be sourced last
[ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ] && source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh # Must be sourced last

