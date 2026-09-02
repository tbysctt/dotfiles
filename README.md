# Dotfiles

This repo is designed to manage dotfiles with [GNU Stow](https://www.gnu.org/software/stow/stow.html).

Stow allows you to easily manage collections of symlinks, which is perfect for dotfiles.

This repo stores multiple configurations, each for a particular program or collections of tightly integrated programs (such as `hyprland`, `hyprlock`, `hypridle` and `hyprpaper`, which are all included in the [hyprland](./hyprland) configuration).

The configurations are stored in separate directories in the root of the repo. You "install" a configuration by running `stow <config dir name>` from within the repo, which will create symlinks for all files in the specified directory in the target directory. Each configuration's directory is structured to mirror a home directory with the expectation that your own home directory is the target.

Note that Stow's default target is actually the parent directory of the current working directory, so it's easiest to clone this repo directly into your home directory. Otherwise you'll need to include the `--target $HOME` flag in your `stow` commands to specify your home directory as the target. Your choice :)

## Get started

1. Install GNU Stow

2. Clone this repo to your home directory

3. Install configurations with `stow <configuration directory name>`. For example:

   ```sh
   stow neovim # Symlinks everything in 'neovim' directory
   stow git    # Symlinks everything in the 'git' directory
   ```

   You can install multiple packages at once:

   ```sh
   stow neovim zsh git alacritty # Symlinks everything in the 'neovim', 'zsh', 'git' and 'alacritty' directories
   ```

## Important notes about each config

### Neovim

A modern configuration of Neovim, requiring at least 0.12.x as it uses the new built-in `vim.pack` package manager.

It uses Mason for installing LSPs, unless `NEOVIM_USE_MASON` is set to `false`, in which case Mason will not be configured or used at all. In that case, you'll need to manually install any tools you wish to use.

It also supports an HTTP proxy URL to be set via the `NEOVIM_HTTP_PROXY` environment variable. This allows the same config to be used on corporate machines that require an HTTP proxy for any web fetch requests, such as for fetching schemas for YAML LS and JSON LS.

### LazyVim

A separate LazyVim distribution install at `~/.config/lazyvim/`. This was what I was using while I learnt Neovim, before writing my own config from scratch.

Customisations from the OOTB LazyVim experience include:

- Replaces the large LAZYVIM ASCII header with "Welcome"
- Dashboard shows root/CWD, git status, git log, and Neovim/LazyVim versions
- Sets conceal level to zero — this was extremely annoying when writing Markdown
- Explorer shows hidden files with normal font colour; git-ignored files appear greyed out
- Files picker shows hidden files but not git-ignored files
- `<leader>l*` keymaps for Lazy, LazyHealth, config, and extras
- Opens the Snacks dashboard when the last buffer is deleted
- Git blame in ghost text on the current line
- Sidekick for AI-assisted programming (via LazyVim extra)
- Language extras: Go, PHP, Python, TypeScript, Terraform, Docker, JSON, TOML, Tailwind, and more
- Disables inlay hints by default

This can be launched with `NVIM_APPNAME=lazyvim nvim`, or `lazyvim` if the ZSH config from this repo is being used.

### Neovim plugin cache

Managing multiple installations of Neovim can be messy if not done properly. If things get messy you can clear all installed plugins and their cache like so:

```sh
rm -r ~/.local/share/nvim
rm -r ~/.local/state/nvim
rm -r ~/.cache/nvim
```

### Alacritty

Alacritty expects the Fira Code Nerd Font to be installed and available.

#### How to install Fira Code Nerd Font on Linux

NOTE: This will be different on MacOS

1. Download the Fira Code Nerd Font

https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip

2. Create a fonts directory (if it doesn't exist):

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

### ZSH

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

It also sources `~/.zsh/extra.zsh` for host-specific additional config, aliases, functions, etc. Example snippets I put in `extra.zsh` on some machines:

Start SSH agent:

```sh
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

### Git

Similar to how ZSH sources `~/.zsh/extra.zsh` (which is not committed) for host-specific config, the Git config points to a `~/.gitconfig.local` file for any additional host-specific or sensitive Git config you'd like to apply, such as GPG config. Create this file to use it as it's not committed.

The global config sets `EDITOR=vim`, uses `main` as the default branch, rebases on pull, and includes a global gitignore for editor and OS junk files.

### OpenCode

- Requires `GITHUB_PERSONAL_ACCESS_TOKEN` for the GitHub MCP server
- Bash permissions: allows most `git *` commands, denies `git add`, `git stage`, `git reset`, and `git commit`
- External directory access: `$HOME/dev/**`
- Custom `chat` agent defined in `agents/chat.md`
- PATH: `~/.opencode/bin` (already set in the ZSH config)

## Notes for new machines

### Mac OS

```sh
# Disable the hold key for accented alternatives
defaults write -g ApplePressAndHoldEnabled -bool false
```
