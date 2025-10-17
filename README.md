# Dotfiles

This repo is designed to manage dotfiles with [GNU Stow](https://www.gnu.org/software/stow/stow.html).

Stow allows you to easily manage collections of symlinks, which is perfect for dotfiles.

This repo stores multiple configurations, each for a particular program or collections of tightly integrated programs (such as `hyprland`, `hyprlock`, `hypridle` and `hyprpaper`, which are all included in the [hyprland](./hyprland) configuration).

The configurations are stored in separate directories in the root of the repo. You "install" a configuration by running `stow <config dir name>` from within the repo, which will create symlinks for all files in the specified directory in the target directory. Each configuration's directory is structured to mirror a home directory with the expectation that your own home directory is the target.

Note that Stow's default target is actually the parent directory of the current working directory, so it's easiest to clone this repo directly into your home directory. Otherwise you'll ned to include the `--target $HOME` flag in your `stow` commands to specify your home directory as the target. Your choice :)

## Get started

1. Install GNU Stow

2. Clone this repo to your home directory

3. Install configurations with `stow <configuration directory name>`. For example, to install the Lazy Vim config in [lazyvim](./lazyvim/), run `stow lazyvim`.

## Notes for new machines

### Mac OS

```sh
# Disable the hold key for accented alternatives
defaults write -g ApplePressAndHoldEnabled -bool false
```
