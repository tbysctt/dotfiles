# Add personal local binaries to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/bin"

# From the Go docs, adds "go" command to path
export PATH=$PATH:/usr/local/go/bin
# This is where Go installs things to (ie. lazygit) with "go install"
export PATH="$HOME/go/bin:$PATH"

if [[ "$(uname -s)" == "Darwin" ]]; then
    # Set PATH, MANPATH, etc., for Homebrew.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
