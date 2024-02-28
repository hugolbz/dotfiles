-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Default shell
config.default_prog = { '/bin/bash', '-l' }

-- Change UI
config.color_scheme = 'Gogh (Gogh)'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.font = wezterm.font 'FiraMono Nerd Font Mono'

config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true

-- Scrolling
config.scrollback_lines = 10000
local act = wezterm.action
config.keys = {
  { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
}

-- and finally, return the configuration to wezterm
return config

