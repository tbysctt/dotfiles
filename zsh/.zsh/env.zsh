export TOOLBOX_IMAGE=ghcr.io/tbysctt/toolbox:latest

export VISUAL="nvim"
export EDITOR="nvim"

# Enable GPG signing for Git commits
export GPG_TTY=$(tty)

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm, but for the sake of initial shell startup time, it skips checking for any .nvmrc file to auto-use a particular version
