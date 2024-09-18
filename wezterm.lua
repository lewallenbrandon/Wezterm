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
config.window_background_opacity = .7
config.macos_window_background_blur = 30
config.window_decorations = 'RESIZE'
config.font = wezterm.font "JetBrains Mono"
config.keys = {
    { key = '/', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = '[', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'SUPER', action = act.ActivateTabRelative(1) },
    { key = '_', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'f', mods = 'SUPER', action = act.ToggleFullScreen},
    { key = 'z', mods = 'SUPER', action = wezterm.action.EmitEvent 'toggle-tab-bar'},
    --{ key = 'h', mods = 'SUPER', action = act.Hide },
    { key = 'h', mods = 'SUPER', action = act.HideApplication },
    { key = 'm', mods = 'SUPER', action = act.TogglePaneZoomState },
    { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
    { key = 'phys:Escape', mods = 'SUPER', action = act.ActivateCommandPalette },
    { key = 'p', mods = 'SUPER', action = projects.choose_project() },
    { key = 'P', mods = 'SUPER', action = act.ShowLauncherArgs {flags = 'FUZZY|WORKSPACES'}, },
    { key = 'r', mods = 'SUPER', action = act.RotatePanes "Clockwise" },
    { key = 's', mods = 'SUPER', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = 'S', mods = 'SHIFT|SUPER', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'T', mods = 'SHIFT|SUPER', action = act.ShowTabNavigator},
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SHIFT|SUPER', action = act.ActivateCopyMode },
    { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane{ confirm = true } },
    { key = 'W', mods = 'SHIFT|SUPER', action = act.CloseCurrentTab{ confirm = true } },
    { key = 'PageUp', mods = 'SUPER', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SUPER', action = act.ScrollByPage(1) },
    { key = 'LeftArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Left' },
    { key = 'LeftArrow', mods = 'SHIFT|SUPER', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'SHIFT|SUPER', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow', mods = 'SHIFT|SUPER', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow', mods = 'SHIFT|SUPER', action = act.AdjustPaneSize{ 'Down', 1 } },
  }

-- and finally, return the configuration to wezterm
return config
