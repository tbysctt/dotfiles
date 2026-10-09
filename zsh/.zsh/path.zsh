# Add personal local binaries to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# OpenCode
# Host-specific overlay (agents/skills/commands/opencode.jsonc). Directory is
# always present so OPENCODE_CONFIG_DIR is safe; content is optional.
mkdir -p "$HOME/.config/opencode-overlay"
export OPENCODE_CONFIG_DIR="$HOME/.config/opencode-overlay"

# From the Go docs, adds "go" command to path
export PATH=$PATH:/usr/local/go/bin
# This is where Go installs things to (ie. lazygit) with "go install"
export PATH="$HOME/go/bin:$PATH"

if [[ "$(uname -s)" == "Darwin" ]]; then
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
