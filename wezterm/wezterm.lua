local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font and text rendering.
-- "Mono" preserves fixed-width alignment in terminals, tmux, and Neovim.
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14.0
config.harfbuzz_features = {
  "calt=1",
  "clig=1",
  "liga=1",
}

-- Use the same palette as Neovim and tmux.
config.color_scheme = "Catppuccin Macchiato"

-- Keep terminal and tmux panes near-black.
config.colors = {
  background = "#090b14",
}

-- Cursor and terminal behaviour.
config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0
config.scrollback_lines = 20000
config.audible_bell = "Disabled"

-- Required by image.nvim's Kitty backend.
config.enable_kitty_graphics = true

-- Keep an opaque, readable terminal background.
config.window_background_opacity = 1.0
config.window_padding = {
  left = 12,
  right = 12,
  top = 8,
  bottom = 8,
}

-- Make both Option keys available as Alt/Meta in zsh, tmux, and Neovim.
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- tmux owns session and window navigation, so avoid a duplicate WezTerm tab bar.
config.enable_tab_bar = false

-- Toggle fullscreen with Ctrl-Enter.
config.keys = {
  {
    key = "Enter",
    mods = "CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
