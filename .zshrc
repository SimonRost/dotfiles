# ~/.zshrc
#
# Interactive Zsh configuration.
# Managed by ~/dotfiles.
#
# Private, machine-specific settings belong in ~/.zshrc.local (not tracked by git).

# Do not load interactive configuration for non-interactive shells.
[[ -o interactive ]] || return

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Shared shell aliases and functions.
[[ -f "$DOTFILES_DIR/shell/aliases.sh" ]] && source "$DOTFILES_DIR/shell/aliases.sh"
[[ -f "$DOTFILES_DIR/shell/functions.sh" ]] && source "$DOTFILES_DIR/shell/functions.sh"

# Docker Desktop completion definitions, if installed.
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

# Initialise Zsh completion support after all completion directories are added.
autoload -Uz compinit
compinit

# Fuzzy finder key bindings and completion, if fzf is installed.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Smarter directory navigation, if zoxide is installed.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Private, machine-specific interactive configuration.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Java: use JDK 21 LTS as the default development toolchain.
export JAVA_HOME="$("/usr/libexec/java_home" -v 21)"
export PATH="$JAVA_HOME/bin:$PATH"

# Tmux leader c-s
stty -ixon

# Prompt and interactive command-line enhancements.
eval "$(starship init zsh)"

# Suggest commands from shell history.
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Highlight valid commands, paths, and shell syntax while typing.
# This must remain the final line in .zshrc.
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
