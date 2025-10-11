# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Edit $PATH variable to include commands in ~/.local/bin
export PATH=$PATH:~/.local/bin

alias ls='ls --color=auto'

alias l='ls -al'

# PS1='[\u \W]\$ '
PS1='\W $ '

# Run neofetch on terminal startup
neofetch
