#!/bin/bash

# Exit on error
set -e

# Variables
DOTFILES_REPO="https://codeberg.org/eldacar/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
KITTY_CONFIG_DIR="$HOME/.config/kitty"
NVIM_PLUGINS_DIR="$NVIM_CONFIG_DIR/lua/plugins"

# Clone dotfiles repo
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repo..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "Dotfiles repo already exists. Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
fi

# Install or update Neovim and Kitty
echo "Checking/updating Neovim and Kitty..."
if ! command -v nvim &> /dev/null; then
    echo "Neovim not found. Installing..."
    sudo apt update && sudo apt install -y neovim
else
    echo "Neovim is installed. Updating..."
    sudo apt update && sudo apt upgrade -y neovim
fi

if ! command -v kitty &> /dev/null; then
    echo "Kitty not found. Installing..."
    sudo apt update && sudo apt install -y kitty
else
    echo "Kitty is installed. Updating..."
    sudo apt update && sudo apt upgrade -y kitty
fi

# Create symlinks
echo "Creating symlinks..."
mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
mkdir -p "$(dirname "$KITTY_CONFIG_DIR")"
mkdir -p "$NVIM_PLUGINS_DIR"

# Remove existing configs if they are not symlinks
[ -L "$NVIM_CONFIG_DIR" ] || rm -rf "$NVIM_CONFIG_DIR"
[ -L "$KITTY_CONFIG_DIR" ] || rm -rf "$KITTY_CONFIG_DIR"

# Create symlinks for nvim and kitty configs
ln -sfn "$DOTFILES_DIR/nvim" "$NVIM_CONFIG_DIR"
ln -sfn "$DOTFILES_DIR/kitty" "$KITTY_CONFIG_DIR"

# Ensure the plugins directory exists in the dotfiles repo
if [ -f "$DOTFILES_DIR/nvim/lua/plugins/init.lua" ]; then
    echo "Symlinking init.lua for plugins..."
    mkdir -p "$(dirname "$NVIM_PLUGINS_DIR/init.lua")"
    ln -sfn "$DOTFILES_DIR/nvim/lua/plugins/init.lua" "$NVIM_PLUGINS_DIR/init.lua"
else
    echo "Warning: $DOTFILES_DIR/nvim/lua/plugins/init.lua does not exist."
fi

echo "Setup complete!"
