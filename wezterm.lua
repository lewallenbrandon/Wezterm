-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local projects = require 'projects'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Custom Functions 
-- Function for enabling and disabling tab bar 
wezterm.on('toggle-tab-bar', function(window, pane) 
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar then
		overrides.enable_tab_bar = false
	else
		overrides.enable_tab_bar = true
	end
	window:set_config_overrides(overrides)
end)


-- For example, changing the color scheme:
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
--config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = .9
config.macos_window_background_blur = 30
config.window_decorations = 'RESIZE'
config.font = wezterm.font "JetBrains Mono"
config.keys = {
    { key = '/', mods = 'ALT', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '_', mods = 'ALT', action = act.DecreaseFontSize },
    { key = '=', mods = 'ALT', action = act.IncreaseFontSize },
    { key = 'c', mods = 'ALT', action = act.CopyTo 'Clipboard' },
		--key 'd' taken to do directory stuff using fzf
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen},
    { key = 'z', mods = 'ALT', action = wezterm.action.EmitEvent 'toggle-tab-bar'},
    --{ key = 'h', mods = 'ALT', action = act.Hide },
    { key = 'h', mods = 'ALT', action = act.HideApplication },
    { key = 'm', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'n', mods = 'ALT', action = act.SpawnWindow },
    { key = 'phys:Escape', mods = 'ALT', action = act.ActivateCommandPalette },
    { key = 'p', mods = 'ALT', action = projects.choose_project() },
    { key = 'P', mods = 'ALT', action = act.ShowLauncherArgs {flags = 'FUZZY|WORKSPACES'}, },
    { key = 'r', mods = 'ALT', action = act.RotatePanes "Clockwise" },
    { key = 's', mods = 'ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = 'S', mods = 'SHIFT|ALT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = 'q', mods = 'ALT', action = act.QuitApplication },
    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'T', mods = 'SHIFT|ALT', action = act.ShowTabNavigator},
    { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SHIFT|ALT', action = act.ActivateCopyMode },
    { key = 'w', mods = 'ALT', action = act.CloseCurrentPane{ confirm = true } },
    { key = 'W', mods = 'SHIFT|ALT', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'PageUp', mods = 'ALT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'ALT', action = act.ScrollByPage(1) },
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'LeftArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize{ 'Down', 1 } },
  }

-- and finally, return the configuration to wezterm
return config
