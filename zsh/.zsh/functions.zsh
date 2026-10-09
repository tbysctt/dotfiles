FZF_CD_IGNORE=(node_modules .git .venv venv __pycache__ dist build target .next .cache)

function cd_fzf() {
    local search_dir="${1:-.}"
    local max_depth="${2:-}"
    local exclude_args=()
    for pattern in "${FZF_CD_IGNORE[@]}"; do
        exclude_args+=(--exclude "$pattern")
    done
    local depth_args=()
    [[ -n "$max_depth" ]] && depth_args=(--max-depth "$max_depth")

    local selected_dir
    selected_dir=$(fd -t d -H "${exclude_args[@]}" "${depth_args[@]}" . "$search_dir" |
        fzf +m --height 50% --preview 'tree -C {}')
    if [[ -n "$selected_dir" ]]; then
        cd "$selected_dir" || return 1
    fi
}

alias cdh='cd_fzf ~'

REPOS_DIR="$HOME/git"
alias cdd='cd_fzf "$REPOS_DIR" 2'

# Yazi shell wrapper that provides the ability to change the CWD when exiting Yazi. Exit with "q" to change, exit with "Q" to not change.
# See: https://github.com/yazi-rs/yazi-rs.github.io/blob/main/versioned_docs/version-26.5.6/quick-start.md?plain=1#L19
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    command rm -f -- "$tmp"
}

# Clipboard copy/paste that pick the right tool for the environment (macOS, X11, or Wayland).
# echo "Hello World" | cbc
# cbp > new_file.txt

_clipboard_cmd() {
    local mode="$1"
    case "$(uname -s)" in
    Darwin)
        if [[ "$mode" == copy ]]; then
            pbcopy
        else
            pbpaste
        fi
        ;;
    Linux)
        if [[ "$mode" == copy ]]; then
            if [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy >/dev/null 2>&1; then
                wl-copy
            elif [ -n "$DISPLAY" ] && command -v xclip >/dev/null 2>&1; then
                xclip -selection clipboard
            elif [ -n "$DISPLAY" ] && command -v xsel >/dev/null 2>&1; then
                xsel --clipboard --input
            else
                echo "cbc: no clipboard tool found" >&2
                return 1
            fi
        else
            if [ -n "$WAYLAND_DISPLAY" ] && command -v wl-paste >/dev/null 2>&1; then
                wl-paste
            elif [ -n "$DISPLAY" ] && command -v xclip >/dev/null 2>&1; then
                xclip -selection clipboard -o
            elif [ -n "$DISPLAY" ] && command -v xsel >/dev/null 2>&1; then
                xsel --clipboard --output
            else
                echo "cbp: no clipboard tool found" >&2
                return 1
            fi
        fi
        ;;
    *)
        local name=cbc
        [[ "$mode" == paste ]] && name=cbp
        echo "$name: unsupported OS" >&2
        return 1
        ;;
    esac
}

cbc() {
    _clipboard_cmd copy
}

cbp() {
    _clipboard_cmd paste
}

# Scripts to setup experiment environments in a temporary directory

go-experiment() {
    cd $(mktemp -d)
    go mod init example.com/go-experiment
    git init
    touch main.go
    nv
}

py-experiment() {
    cd $(mktemp -d)
    poetry new . --name "experiment"
    git init
    nv
}
