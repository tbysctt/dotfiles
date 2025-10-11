# My dotfiles, managed with GNU Stow

Stow will create symlinks in the target directory.

Each directory in this repo is specific to a program and is structured as though it is the home directory.

## Setup

Install GNU Stow and clone this repo.

## ZSH

```sh
stow zsh -t $HOME
```

## Alacritty

```sh
stow alacritty -t $HOME
```

## Notes for new machines

### Mac OS

```sh
# Disable the hold key for accented alternatives
defaults write -g ApplePressAndHoldEnabled -bool false
```
