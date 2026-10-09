# Add version control support
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst # Enable prompt substitution for variable expansion
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats ' %b %u%c'            # %u = unstaged changes, %c = staged changes, %b = branch name
zstyle ':vcs_info:git:*' actionformats ' %b (%a) %u%c' # %a = action git is currently performing ("merge" or "rebase")
zstyle ':vcs_info:git:*' unstagedstr '* '
zstyle ':vcs_info:git:*' stagedstr '+ '
zstyle ':vcs_info:*:*' check-for-changes true # This enables %u and %c (unstaged/staged changes) to work, but can be slow on large repos

PROMPT='%F{blue}%1~%f ${vcs_info_msg_0_}%# '
RPROMPT='%(?.%F{green}✓.%F{red}×)%f %n@%m ($(uname -s))'
