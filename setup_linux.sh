#!/usr/bin/env bash

# IMPORTANT
# - Run this script from a Git clone located at ~/dotfiles.
# - Git must already be installed to clone the repository.
# - This script supports APT-based Linux distributions:
#   Ubuntu, Kali Linux, and Linux Mint.
# - Packages are read from packages/apt.txt.
# - Existing configuration files are backed up with a timestamp before changes.
# - The script does not run git pull or modify repository contents.
# - No secrets should be stored in this repository.

set -Eeuo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APT_PACKAGES_FILE="$DOTFILES_DIR/packages/apt.txt"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

die() {
  echo "Error: $*" >&2
  exit 1
}

require_source() {
  local source_path="$1"

  [[ -e "$source_path" ]] || die "Required source does not exist: $source_path"
}

link_config() {
  local source_path="$1"
  local target_path="$2"
  local backup_path

  require_source "$source_path"
  mkdir -p "$(dirname "$target_path")"

  if [[ -L "$target_path" ]] && [[ "$(readlink "$target_path")" == "$source_path" ]]; then
    echo "Already linked: $target_path -> $source_path"
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="${target_path}.backup.${TIMESTAMP}"

    echo "Backing up existing path:"
    echo "  $target_path -> $backup_path"

    mv "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"

  echo "Created link:"
  echo "  $target_path -> $source_path"
}

verify_link() {
  local source_path="$1"
  local target_path="$2"

  if [[ -L "$target_path" ]] && [[ "$(readlink "$target_path")" == "$source_path" ]]; then
    echo "Verified: $target_path"
  else
    die "Verification failed for: $target_path"
  fi
}

[[ "$(uname -s)" == "Linux" ]] || die "This script must run on Linux."
command -v apt-get >/dev/null 2>&1 || die "APT was not found on this system."
[[ -d "$DOTFILES_DIR/.git" ]] || die "Expected a Git repository at: $DOTFILES_DIR"
[[ "$SCRIPT_DIR" == "$DOTFILES_DIR" ]] || die "Run the script from: $DOTFILES_DIR"

require_source "$APT_PACKAGES_FILE"
require_source "$DOTFILES_DIR/nvim"
require_source "$DOTFILES_DIR/wezterm"
require_source "$DOTFILES_DIR/tmux/tmux.conf"
require_source "$DOTFILES_DIR/.zprofile"
require_source "$DOTFILES_DIR/.zshrc"
require_source "$DOTFILES_DIR/.bashrc"

if [[ "$EUID" -eq 0 ]]; then
  APT_COMMAND=(apt-get)
else
  command -v sudo >/dev/null 2>&1 || die "sudo is required when not running as root."
  APT_COMMAND=(sudo apt-get)
fi

echo "Refreshing APT package metadata..."
"${APT_COMMAND[@]}" update

available_packages=()
unavailable_packages=()

while IFS= read -r package || [[ -n "$package" ]]; do
  case "$package" in
    ""|\#*)
      continue
      ;;
  esac

  if apt-cache show "$package" >/dev/null 2>&1; then
    available_packages+=("$package")
  else
    unavailable_packages+=("$package")
  fi
done < "$APT_PACKAGES_FILE"

if (( ${#available_packages[@]} > 0 )); then
  echo
  echo "Installing available APT packages:"
  printf '  %s\n' "${available_packages[@]}"

  "${APT_COMMAND[@]}" install -y "${available_packages[@]}"
fi

if (( ${#unavailable_packages[@]} > 0 )); then
  echo
  echo "Warning: unavailable in the configured APT repositories:"
  printf '  %s\n' "${unavailable_packages[@]}" >&2
fi

echo
echo "Deploying dotfile symlinks..."

link_config "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_config "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
link_config "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
link_config "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
link_config "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_config "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"

echo
echo "Verifying symlinks..."

verify_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
verify_link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
verify_link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
verify_link "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
verify_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
verify_link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"

echo
echo "Verifying installed terminal tools..."

for tool in git nvim tmux wezterm eza fzf zoxide; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "Found: $tool"
  else
    echo "Warning: expected tool not found in PATH: $tool" >&2
  fi
done

echo
echo "Linux dotfiles setup complete."
echo "Open a new terminal window to load the linked shell configuration."
