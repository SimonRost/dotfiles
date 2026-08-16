# ~/.zprofile
#
# Login-shell environment configuration.
# Managed by ~/dotfiles.
#
# Private, machine-specific settings belong in ~/.zprofile.local (not tracked by git).

# Homebrew
# Supports Apple Silicon and older Intel-based Homebrew locations.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done

# Keep PATH entries unique.
typeset -U path PATH

# User-installed Python tools, including pipx applications.
[[ -d "$HOME/.local/bin" ]] && path+=("$HOME/.local/bin")

# Docker Desktop command-line tools, if Docker Desktop is installed.
[[ -d "$HOME/.docker/bin" ]] && path+=("$HOME/.docker/bin")

# MacTeX command-line tools, if installed.
[[ -d "/Library/TeX/texbin" ]] && path+=("/Library/TeX/texbin")

# OrbStack integration, if OrbStack is installed.
[[ -f "$HOME/.orbstack/shell/init.zsh" ]] && \
  source "$HOME/.orbstack/shell/init.zsh"

# Private, machine-specific environment configuration.
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
