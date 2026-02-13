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

## Important notes about each config

#### Neovim

The Neovim config is uses the LazyVim distribution, with a few customisations, such as:

- Remove massive "LAZYVIM" graphic from Dashboard
- Show GitHub repo information on the Dashboard (requires GitHub CLI to be installed)
- Sets conceal level to zero - This was extremely annoying when writing Markdown
- Shows hidden and git-ignored files in the Explorer. Makes hidden files appear with "Normal" font colour, and only the git-ignored files to appear with the greyed-out font colour.
- Shows hidden files in the Files picker, but not git-ignored files.
- Adds some additional keymaps to make it easier to jump to the LazyVim config and healthcheck
- Opens the Snacks Dashboard when the last buffer is deleted
- Shows a Git Blame in ghost text on the current line
- Installs Sidekick for AI assisted programming
- Adds language support for JavaScript/TypeScript, Go, PHP
- Disables inlay hints by default

#### Alacritty

Alacritty expects the Fira Code Nerd Font to be installed and available.

1. Download the Fira Code Nerd Font

https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip

2. Create a fonts directory (if it doesn’t exist):

```sh
# For system-wide
sudo mkdir -p /usr/local/share/fonts/nerd-fonts/FiraCode

# For your user only
mkdir -p ~/.local/share/fonts/FiraCode
```

3. Copy or move the font files (e.g., .ttf or .otf) into that directory.

4. Grant correct permissions if system-wide:

```sh
sudo chown -R root: /usr/local/share/fonts/nerd-fonts/FiraCode
sudo chmod 644 /usr/local/share/fonts/nerd-fonts/FiraCode/*
```

5. Rebuild the font cache

```sh
fc-cache -fv
```

6. Verify the font is installed

```sh
fc-list | grep -i "FiraCode"
```

#### ZSH

To make ZSH your default shell, run the following. Note that if you use `sudo`, it will change the default shell for the root user instead of your user.

```sh
chsh -s $(which zsh)
```

ZSH expects that the following plugins are cloned to `~/.zsh/*`.

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search
```

It also sources `~/.zsh/extra.zsh` for host-specific additional config, aliases, functions, etc. Example snippets I put in `extra.sh` on some machines:

Start SSH agent:

```sh
# # SSH agent setup I had in Arch PC's .zshrc
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#   ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [ ! -f "$SSH_AUTH_SOCK" ]; then
#   source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# figure out which of these is the better/ideal/proper one and clean this up

# SSH agent setup I had in arch laptop's .zprofile
if [ -z "$SSH_AUTH_SOCK" ]; then
  # Check for a currently running instance of the agent
  RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
  if [ "$RUNNING_AGENT" = "0" ]; then
    # Launch a new instance of the agent
    ssh-agent -s &> $HOME/.ssh/ssh-agent
  fi
  eval `cat $HOME/.ssh/ssh-agent`
fi
```

Set keyboard brightness on the Lenovo laptop:

```sh
brightnessctl --device='platform::kbd_backlight' set 1
```

#### Git

Similar to how ZSH sources `~/.zsh/extra.zsh` (which is not committed) for host-specific config, the Git config points to a `~/.gitconfig.local` file for any additional host-specific or sensitive Git config you'd like to apply, such as GPG config. Create this file to use it as it's not committed.

## Notes for new machines

### Mac OS

```sh
# Disable the hold key for accented alternatives
defaults write -g ApplePressAndHoldEnabled -bool false
```
