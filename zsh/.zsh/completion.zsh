# Initialise the Zsh completion system, enabling tab completion for commands, arguments, filenames, and repository elements like Git branches and remotes.
autoload -Uz compinit

# Check the cache once a day rather than every time
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
    compinit -C
else
    compinit
fi

if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

if command -v aws_completer &>/dev/null; then
    autoload -Uz bashcompinit && bashcompinit # Uses bash-style completion via aws_completer
    complete -C "$(command -v aws_completer)" aws
fi

if command -v fzf &>/dev/null; then
    source <(fzf --zsh) # Adds Ctrl+R, Ctrl+T, Alt+C bindings
fi
