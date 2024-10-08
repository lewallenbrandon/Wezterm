local wezterm = require 'wezterm'
local module = {}
local home_dir = wezterm.home_dir

local function project_dirs()
  return {
		home_dir .. "/.config",
    home_dir .. "/Emerson",
    home_dir .. "/Projects/CPP",
    home_dir .. "/Projects/CraftingInterpreters",
    home_dir .. "/Projects/SoftwareDesign",
    home_dir .. "/Vim",
    -- ... keep going, list all your projects
    -- (or don't if you value your time. we'll improve on this soon)
  }
end

function module.choose_project()
  local choices = {}
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end
  -- The InputSelector action presents a modal UI for choosing between a set of options
  -- within WezTerm.
  return wezterm.action.InputSelector {
    title = 'Projects',
    -- The options we wish to choose from
    choices = choices,
    -- Yes, we wanna fuzzy search (so typing "alex" will filter down to
		-- "~/Projects/alexplescan.com")
		fuzzy = true,
		-- The action we want to perform. Note that this doesn't have to be a
		-- static definition as we've done before, but can be a callback that
		-- evaluates any arbitrary code.
		action = wezterm.action_callback(function(child_window, child_pane, id, label)
			-- As a placeholder, we'll log the name of what you picked
			if not label then return end

			-- The SwitchToWorkspace action will switch us to a workspace if it already exists,
			-- otherwise it will create it for us.
			child_window:perform_action(wezterm.action.SwitchToWorkspace {
				-- We'll give our new workspace a nice name, like the last path segment
				-- of the directory we're opening up.
				name = label:match("([^/]+)$"),
				-- Here's the meat. We'll spawn a new terminal with the current working
				-- directory set to the directory that was picked.
				spawn = { cwd = label },
			}, child_pane)
		end),
	}
end

return module
