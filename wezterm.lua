-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local projects = require 'projects'

-- This will hold the configuration.
local config = wezterm.config_builder()



-- For example, changing the color scheme:
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.initial_cols = 200
config.initial_rows = 60
--config.color_scheme = 'Catppuccin Mocha (Gogh)'
--config.color_scheme = 'Tokyo Night'
--config.color_scheme = 'Github Dark (Gogh)'
config.color_scheme = 'Vs Code Dark+ (Gogh)'
config.window_background_opacity = 1
config.macos_window_background_blur = 30
config.window_decorations = 'RESIZE'
config.font = wezterm.font "FiraCode Nerd Font"
config.keys = {
    { key = '/', mods = 'ALT', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '-', mods = 'ALT', action = act.DecreaseFontSize },
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
    { key = 'P', mods = 'ALT', action = projects.choose_project() },
    { key = 'p', mods = 'ALT', action = act.ShowLauncherArgs {flags = 'FUZZY|WORKSPACES'}, },
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
    { key = 'LeftArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize{ 'Left', 1 } },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize{ 'Right', 1 } },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'UpArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize{ 'Up', 1 } },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'DownArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize{ 'Down', 1 } },
    { key = 'R', mods = 'SHIFT|SUPER',
      action = act.PromptInputLine { description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  }

-- and finally, return the configuration to wezterm
return config
