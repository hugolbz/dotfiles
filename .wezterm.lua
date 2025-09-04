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
-- Slightly transparent and blurred background
config.window_background_opacity = 0.99

config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'Gogh (Gogh)'
-- config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.window_decorations = "RESIZE"

config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  -- font = wezterm.font({ family = 'Berkeley Mono', weight = 'Bold' }),
  font_size = 12,
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- config.font = wezterm.font 'FiraMono Nerd Font Mono'

config.hide_tab_bar_if_only_one_tab = false
config.force_reverse_video_cursor = true

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-- Scrolling
config.scrollback_lines = 30000
local act = wezterm.action
config.keys = {
  { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
}

-- status
local function segments_for_right_status(window, pane)
    local cwd = ""
    local hostname = ""
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        cwd = cwd_uri.file_path
        hostname = cwd_uri.host
    end

  return {
    cwd,
    hostname,
    wezterm.strftime('%a %b %-d %H:%M'),
    -- window:active_workspace(),
    -- wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, pane)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window, pane)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg
  -- if wezterm.gui.get_appearance():find("Dark") then
    gradient_from = gradient_to:lighten(0.2)
  -- else
  --   gradient_from = gradient_to:darken(0.2)
  -- end

  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

local process_icons = {
  ['bash'] = wezterm.nerdfonts.dev_terminal,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['curl'] = wezterm.nerdfonts.mdi_flattr,
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['gitui'] = wezterm.nerdfonts.dev_git,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['lazydocker'] = wezterm.nerdfonts.linux_docker,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['nvim'] = wezterm.nerdfonts.custom_neovim,
  ['psql'] = '󱤢',
  ['python3'] = wezterm.nerdfonts.custom_neovim,
  ['python3.8'] = wezterm.nerdfonts.custom_neovim,
  ['ruby'] = wezterm.nerdfonts.cod_ruby,
  ['ssh'] = wezterm.nerdfonts.md_remote_desktop,
  ['ssh-add'] = wezterm.nerdfonts.md_remote_desktop,
  ['sudo'] = wezterm.nerdfonts.fa_hashtag,
  ['tig'] = wezterm.nerdfonts.dev_git,
  ['usql'] = '󱤢',
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
}
local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
  local HOME_DIR = os.getenv('HOME')

    -- remove trailing slash
  local current_dirname = string.gsub(current_dir.file_path, '%/$', '')
  return current_dirname == HOME_DIR and '~'
    or string.gsub(current_dirname, '(.*[/\\])(.*)', '%2')
end

local function get_process(tab)
  if not tab.active_pane or tab.active_pane.foreground_process_name == '' then
    return nil
  end

  local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
  if string.find(process_name, 'kubectl') then
    process_name = 'kubectl'
  end

  return process_icons[process_name] or string.format('[%s]', process_name)
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local has_unseen_output = false
  if not tab.is_active then
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
  end

  local cwd = wezterm.format({
    { Text = get_current_working_dir(tab) },
  })

  local process = get_process(tab)
  local title = process and string.format(' %s  %s ', cwd, process) or ' [?] '

  if has_unseen_output then
    return {
      { Foreground = { Color = '#28719c' } },
      { Text = title },
    }
  end

  return {
    { Text = title },
  }
end)

-- and finally, return the configuration to wezterm
return config

