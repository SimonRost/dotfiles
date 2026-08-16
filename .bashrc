# ~/.bashrc
#
# Interactive Bash configuration.
# Managed by ~/dotfiles.
#
# Private, machine-specific settings belong in ~/.bashrc.local (not tracked by git).

# Do not load interactive configuration for non-interactive shells.
case "$-" in
  *i*) ;;
  *) return ;;
esac

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Shared shell aliases and functions.
[[ -f "$DOTFILES_DIR/shell/aliases.sh" ]] && source "$DOTFILES_DIR/shell/aliases.sh"
[[ -f "$DOTFILES_DIR/shell/functions.sh" ]] && source "$DOTFILES_DIR/shell/functions.sh"

# Fuzzy finder key bindings and completion, if fzf is installed.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --bash)
fi

# Smarter directory navigation, if zoxide is installed.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# Private, machine-specific interactive configuration.
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
