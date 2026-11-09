-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Check if the target triple contains "windows"
local is_windows = wezterm.target_triple:find("windows") ~= nil
if is_windows then
    config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-l' }
else
    config.default_prog = { '/bin/bash', '-l' }
end


-- Change UI
-- Slightly transparent and blurred background
config.window_background_opacity = 0.99

-- Live light/dark scheme switching based on the OS appearance. WezTerm detects
-- appearance changes and reloads this config, so the scheme stays in sync.
-- wezterm.gui is not available to the mux server, so default to dark there.
local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

local function scheme_for_appearance(appearance)
    if appearance:find('Dark') then
        return 'Tokyo Night'
    end
    return 'Tokyo Night Day'
end

config.color_scheme = scheme_for_appearance(get_appearance())
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
    { key = 'UpArrow',   mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },
}
config.set_environment_variables = {
    COLORTERM = 'truecolor', -- Some program (opencode) relies on this being set
}
-- Pick per-host accent colors from the active scheme's resolved palette. The
-- top bar is always dark regardless of light/dark mode, so we always use the
-- bright variants of the active scheme for good contrast. Falls back to the
-- ansi set if a scheme has no brights defined.
local function host_palette_for(resolved_palette)
    local base = resolved_palette and (resolved_palette.brights or resolved_palette.ansi)
    if not base then
        return nil
    end
    return base
end

-- Deterministic per-hostname color derived from a hash of the hostname, using
-- a palette taken from the active theme's resolved palette instead of
-- hardcoded hex values. Returns nil when no palette is available.
local function hostname_color(host, palette)
    if not host or host == '' or not palette then
        return nil
    end
    local h = 0
    for i = 1, #host do
        h = (h * 31 + string.byte(host, i)) % 9973
    end
    return palette[(h % #palette) + 1]
end

-- Resolve the host to color-code: prefer the pane's cwd host (e.g. over SSH),
-- but fall back to the local machine's hostname. The cwd host is nil on
-- Windows (drive paths like C:\ have no host), so this keeps color-coding
-- working there too.
local function effective_host(cwd_uri)
    local host = cwd_uri and cwd_uri.host
    if host and host ~= '' then
        return host
    end
    return wezterm.hostname()
end

-- status
local function segments_for_right_status(window, pane)
    local cwd = ""
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        cwd = cwd_uri.file_path
    end
    local hostname = effective_host(cwd_uri)

    -- Per-host accents always use the active scheme's brights, since the
    -- top/status bar stays dark in both light and dark mode.
    local host_palette = host_palette_for(window:effective_config().resolved_palette)

    return {
        string.format(' %s  %s ', wezterm.nerdfonts.md_folder, cwd),
        { text = string.format(' %s  %s ', wezterm.nerdfonts.md_monitor, hostname), color = hostname_color(hostname, host_palette) },
        string.format(' %s  %s ', wezterm.nerdfonts.md_calendar_clock, wezterm.strftime('%a %b %-d %H:%M')),
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
    -- Darken or lighten depending on whether the active scheme is light/dark,
    -- so the powerline segments stay visible in both appearances.
    if window:get_appearance():find('Dark') then
        gradient_from = gradient_to:lighten(0.2)
    else
        gradient_from = gradient_to:darken(0.2)
    end

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

        local seg_text = seg
        local seg_color = fg
        if type(seg) == 'table' then
            seg_text = seg.text
            seg_color = seg.color or fg
        end

        table.insert(elements, { Foreground = { Color = seg_color } })
        table.insert(elements, { Background = { Color = gradient[i] } })
        table.insert(elements, { Text = ' ' .. seg_text .. ' ' })
    end

    window:set_right_status(wezterm.format(elements))
end)

local process_icons = {
    ['bash'] = wezterm.nerdfonts.dev_terminal,
    ['cargo'] = wezterm.nerdfonts.dev_rust,
    ['curl'] = wezterm.nerdfonts.mdi_flattr,
    ['docker'] = wezterm.nerdfonts.linux_docker,
    ['docker-compose'] = wezterm.nerdfonts.linux_docker,
    ['gdb'] = wezterm.nerdfonts.dev_github_badge,
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
    ['opencode'] = wezterm.nerdfonts.cod_hubot,
    ['psql'] = '󱤢',
    ['perl'] = wezterm.nerdfonts.dev_perl,
    ['python3'] = wezterm.nerdfonts.dev_python,
    ['ruby'] = wezterm.nerdfonts.cod_ruby,
    ['ssh'] = wezterm.nerdfonts.md_remote_desktop,
    ['ssh-add'] = wezterm.nerdfonts.md_remote_desktop,
    ['sudo'] = wezterm.nerdfonts.fa_hashtag,
    ['tig'] = wezterm.nerdfonts.dev_git,
    ['usql'] = '󱤢',
    ['uv'] = wezterm.nerdfonts.dev_python,
    ['vim'] = wezterm.nerdfonts.dev_vim,
    ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
    ['wezterm'] = wezterm.nerdfonts.dev_terminal,
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
        return nil, nil
    end

    local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
    process_name = string.gsub(process_name, ".exe", "")
    if string.find(process_name, 'python3') then
        process_name = 'python3'
    end

    local icon = process_icons[process_name] or string.format('[%s]', process_name)
    return icon, process_name
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

    local cwd = get_current_working_dir(tab)
    -- Reuse the same color as the host icon/name on the right status:
    -- a deterministic color derived from the pane's host.
    local tab_host = effective_host(tab.active_pane and tab.active_pane.current_working_dir)

    local default_fg = config.resolved_palette and config.resolved_palette.foreground or 'default'
    -- Per-host accent for the process icon: always the active scheme's brights,
    -- since the top bar stays dark in both light and dark mode.
    local host_palette = host_palette_for(config.resolved_palette)
    local elements = {}

    local process_icon, process_name = get_process(tab)

    -- Color the process icon with the same host color used on the right status.
    -- Fall back to the default foreground if no host color can be derived, so
    -- the tab title always renders cleanly.
    if process_icon then
        table.insert(elements, { Text = ' ' .. cwd .. '  ' })
        table.insert(elements, { Foreground = { Color = hostname_color(tab_host, host_palette) or default_fg } })
        table.insert(elements, { Text = process_icon })
        table.insert(elements, { Foreground = { Color = default_fg } })
    else
        table.insert(elements, { Text = ' ' .. cwd })
    end

    if has_unseen_output then
        -- Use the active scheme's ANSI blue so the indicator adapts to any
        -- theme, falling back to the previous hardcoded color if needed.
        local unseen_fg = (config.resolved_palette and config.resolved_palette.ansi
            and config.resolved_palette.ansi[4]) or '#28719c'
        table.insert(elements, { Foreground = { Color = unseen_fg } })
    end

    table.insert(elements, { Text = ' ' })
    return elements
end)

-- and finally, return the configuration to wezterm
return config
