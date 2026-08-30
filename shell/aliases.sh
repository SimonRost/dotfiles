# shell/aliases.sh
#
# Shared aliases for Zsh and Bash.

# General navigation and file listing.
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'

# Git.
alias gs='git status'
alias gl='git log --oneline --decorate --graph'

# Neovim.
alias vim='nvim'

# Modern directory listings, when eza is installed.
if command -v eza >/dev/null 2>&1; then
  alias e='eza -l'
  alias ela='eza -lah --git'
  alias et='eza --tree'
fi

# LLM (simonw)
alias cmd='llm -m mistral-small -t command'
