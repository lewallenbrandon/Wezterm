-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
local cmdpicker = wezterm.plugin.require 'https://github.com/abidibo/wezterm-cmdpicker'

-- This will hold the configuration.
local config = wezterm.config_builder()

local function tab_decorations(tab, title)
    local element = {}
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Background = { Color = '#24252f' } })
    table.insert(element, { Foreground = { Color = '#d62950' } })

    if tab.tab_index == 0 then -- first tab
        table.insert(element, { Text = ' ' })
    else
        table.insert(element, { Text = '' })
    end
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Foreground = { Color = 'Black' } })
    table.insert(element, { Background = { Color = '#d62950' } })
    table.insert(element, { Text = title })
    table.insert(element, 'ResetAttributes')
    table.insert(element, { Background = { Color = '#24252f' } })
    table.insert(element, { Foreground = { Color = '#d62950' } })
    table.insert(element, { Text = '' })
    return element
end

local function tab_title(tab_info, max_width)
  local title = tab_info.active_pane.title
  local title_num_text = tab_info.tab_index + 1 .. ': '
  local zoomed_flag = '[z]'
  title = wezterm.truncate_left(title, max_width - 5)
  if tab_info.active_pane.is_zoomed then
      title = title_num_text .. zoomed_flag .. title
  else
      title = title_num_text .. title
  end

  -- Otherwise, use the title from the active pane
  -- in that tab
  return title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, conf, hover, max_width)
    local title = tab_title(tab, conf.tab_max_width)
    if tab.is_active then
        title = tab_decorations(tab, title)
    else
        title = ' ' .. title .. ' '
    end
    return title
  end
)

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


config.leader = { key = ' ', mods='ALT',  timeout_milliseconds = 1500 }

config.keys = {
    { key = '/', mods = 'ALT', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '-', mods = 'ALT', action = act.DecreaseFontSize },
    { key = '=', mods = 'ALT', action = act.IncreaseFontSize },
    { key = 'c', mods = 'ALT', action = act.CopyTo 'Clipboard' },
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen},
    --{ key = 'h', mods = 'ALT', action = act.Hide },
    { key = 'h', mods = 'ALT', action = act.HideApplication },
    { key = 'm', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'n', mods = 'ALT', action = act.SpawnWindow },
    { key = 'phys:Escape', mods = 'ALT', action = act.ActivateCommandPalette },
    { key = ' ', mods = 'LEADER|ALT', action = act.ActivateCommandPalette},
    { key = 'q', mods = 'ALT', action = act.QuitApplication },
    { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize', one_shot=false},},
    { key = 's', mods = 'ALT', action = act({ EmitEvent = "load_session" })},
    { key = 's', mods = 'LEADER', action = act.ActivateKeyTable { name = 'sessions', timeout_milliseconds = 1500},},
    { key = 't', mods = 'LEADER', action = act.ActivateKeyTable { name = 'tabs', timeout_milliseconds = 1500},},
    { key = 't', mods = 'ALT',  action = act.SpawnTab 'CurrentPaneDomain'},
    { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SHIFT|ALT', action = act.ActivateCopyMode },
    { key = 'w', mods = 'LEADER', action = act.ActivateKeyTable { name = 'windows', timeout_milliseconds = 1500},},
    { key = 'w', mods = 'ALT', action = act.SpawnWindow},
    { key = 'x', mods = 'ALT', action = act.CloseCurrentPane{ confirm = true } },
    { key = 'z', mods = 'ALT', action = wezterm.action.EmitEvent 'toggle-tab-bar'},
    { key = 'PageUp', mods = 'ALT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'ALT', action = act.ScrollByPage(1) },
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  }
  config.key_tables = {
        windows = {
            { key = 'v',  action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
            { key = 'h',  action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },


        },
        resize = {
            { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
            { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
            { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
            { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
            { key = 'Escape', action = 'PopKeyTable' },
        },
        tabs = {
            { key = 'o',  action = act.SpawnTab 'CurrentPaneDomain' },
            { key = 'f',  action = act.ShowLauncherArgs {flags = 'TABS'}, },
            { key = 'x',  action = act.CloseCurrentTab {confirm = true}, },
            { key = 'r',
                action = act.PromptInputLine { description = 'Enter new name for tab',
                action = wezterm.action_callback(function(window, pane, line)
                    -- line will be `nil` if they hit escape without entering anything
                    -- An empty string if they just hit enter
                    -- Or the actual line of text they wrote
                    if line then
                        window:active_tab():set_title(line)
                    end
            end),},},
        },
        sessions = {
            { key = 'a',  action = act({ EmitEvent = "toggle_autosave" }), },
            { key = 'd',  action = act({ EmitEvent = "delete_session" }), },
            { key = 'e',  action = act({ EmitEvent = "edit_session" }), },
            { key = '<',  action = act({ EmitEvent = "fork_session" }), },
            { key = 'r',  action = act({ EmitEvent = "restore_session" }), },
            { key = 's',  action = act({ EmitEvent = "save_session" }), },
            { key = 'f',  action = act.ShowLauncherArgs {flags = 'FUZZY|WORKSPACES'}, },
            { key = 'R',
              action = act.PromptInputLine {
                  description = 'Enter new workspace name',
                  action = wezterm.action_callback(
                      function(window, pane, line)
                          if line then
                              wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                          end
                      end),},},
            { key = 'o',
              action = act.PromptInputLine {
                  description = wezterm.format {
                      { Attribute = { Intensity = 'Bold' } },
                      { Foreground = { AnsiColor = 'Fuchsia' } },
                      { Text = 'Enter name for new workspace' },
                  },
                  action = wezterm.action_callback(function(window, pane, line)
                      -- line will be `nil` if they hit escape without entering anything
                      -- An empty string if they just hit enter
                      -- Or the actual line of text they wrote
                      if line then
                          window:perform_action(
                              act.SwitchToWorkspace {
                                  name = line,
                              },
                              pane
                          )
                      end
                  end),},},

        },

  }
cmdpicker.apply_to_config(config, {
  title = 'Command Palette',
})

  -- and finally, return the configuration to wezterm
  return config
