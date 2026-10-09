alias nv=nvim
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias tf=terraform
alias cf=codefresh
alias t=tmux
alias nf=fastfetch # fastfetch is a much faster neofetch alternative
alias lg=lazygit

alias ssh="TERM=xterm-256color ssh" # Usually remote machines don't understand the "alacritty" TERM type.
alias diff='diff --color=always'

alias l="ls -al --color=auto"

alias ga="git add"
alias gc="git commit"
alias gst="git status -uall --short --branch" # uall shows all files inside untracked directories
alias gsw="git switch"
alias glo='git log --pretty=format:"%C(yellow)%h%Creset %C(green)%an%Creset %C(blue)(%cr)%Creset %s" --date=format:"%a %d-%m-%Y %H:%M" --graph'

alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias linguist='docker run -t --rm -v $(pwd):/repo:ro crazymax/linguist'

# Use a subshell so we go back to the original directory once Neovim exits
alias dots="(cd $HOME/dotfiles && nvim)"

alias k=kubectl
alias kdebug='kubectl run $(whoami)-debug --rm=true --restart=Never --image=$TOOLBOX_IMAGE --stdin=true --tty=true --pod-running-timeout=10m0s --annotations="cluster-autoscaler.kubernetes.io/safe-to-evict=true"'

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias chrome-no-cors='open -na "Google Chrome" --args --disable-web-security --user-data-dir="/tmp/chrome_dev"'
fi
