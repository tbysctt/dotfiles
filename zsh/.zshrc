# zmodload zsh/zprof

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

set -o interactive_comments

# Explicitly set keybind mode to emacs because ZSH will use vi mode when the EDITOR env var includes "vi"
bindkey -e

# Shared modules
source ~/.zsh/completion.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/path.zsh
source ~/.zsh/env.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh

# Host-specific overlay (not committed)
[ -f ~/.zsh/extra.zsh ] && source ~/.zsh/extra.zsh

# Niceties for interactive shell experience, making it similar to Fish shell.
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ] && source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Fish-like substring history search (must be bound after the plugin is loaded)
bindkey "^[[A" history-substring-search-up
bindkey "^[OA" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[OB" history-substring-search-down

# zprof
