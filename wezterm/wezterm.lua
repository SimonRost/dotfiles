local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font and text rendering.
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12.0
config.harfbuzz_features = {
  'calt=1',
  'clig=1',
  'liga=1',
}

-- Cursor and terminal behavior.
config.default_cursor_style = 'SteadyBar'
config.cursor_blink_rate = 0
config.scrollback_lines = 20000
config.audible_bell = 'Disabled'

-- Enable the Kitty graphics protocol used by image.nvim.
config.enable_kitty_graphics = true

-- Keep normal, opaque backgrounds for readable code, logs, and diffs.
config.window_background_opacity = 1.0
config.window_padding = {
  left = 12,
  right = 12,
  top = 8,
  bottom = 8,
}

-- Use both Option keys as Alt/Meta keys for shell, Neovim, and tmux.
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Cyber-neon palette. It intentionally contrasts with Catppuccin in Neovim.
config.colors = {
  foreground = '#d7f9ff',
  background = '#090b14',
  cursor_bg = '#00f5d4',
  cursor_fg = '#090b14',
  cursor_border = '#00f5d4',
  selection_bg = '#273449',
  selection_fg = '#ffffff',

  ansi = {
    '#151a2d', -- black
    '#ff4d9d', -- red / errors
    '#69ff94', -- green / success
    '#ffe66d', -- yellow / warnings
    '#57c7ff', -- blue
    '#c792ea', -- magenta
    '#00f5d4', -- cyan
    '#d7f9ff', -- white
  },

  brights = {
    '#3b4261', -- bright black
    '#ff75b5', -- bright red
    '#a6ffcb', -- bright green
    '#fff3a3', -- bright yellow
    '#8bd5ff', -- bright blue
    '#e3b7ff', -- bright magenta
    '#70fff0', -- bright cyan
    '#ffffff', -- bright white
  },

  tab_bar = {
    background = '#090b14',

    active_tab = {
      bg_color = '#00f5d4',
      fg_color = '#090b14',
      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = '#151a2d',
      fg_color = '#8bd5ff',
    },

    inactive_tab_hover = {
      bg_color = '#273449',
      fg_color = '#ffffff',
    },

    new_tab = {
      bg_color = '#151a2d',
      fg_color = '#8bd5ff',
    },

    new_tab_hover = {
      bg_color = '#273449',
      fg_color = '#ffffff',
    },
  },
}

-- Use a compact, consistent tab bar rather than native macOS-style tabs.
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Keep the useful fullscreen shortcut from the previous Kitty setup.
config.keys = {
  {
    key = 'Enter',
    mods = 'CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
