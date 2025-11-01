The ZSH config expects OhMyZsh to be installed and the `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins to be cloned.

It also sources `~/.config/extra.sh` for host-specific additional config, aliases, functions, etc. Snippets I put in `extra.sh` on some machines:

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
```
