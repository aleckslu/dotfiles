-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- DEFAULT SHELL
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
config.default_cwd = "$Env:USERPROFILE"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 120
config.quick_select_patterns = {
	"[0-9a-f]{7,40}", -- hashes
	"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", -- uuids
	"https?:\\/\\/\\S+",
}
config.scrollback_lines = 10000
config.status_update_interval = 500

-- LEADER KEY (timeout defaults to 1000, can be ommitted)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
-- config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 3000 }
-- config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 3000 }

-- APPEARANCE
-- THEMES
-- config.color_scheme = "OneDark (base16)"
-- config.color_scheme = "rose-pine"
-- config.color_scheme = "Woodland (base16)"
config.color_scheme = "Catppuccin Frappé (Gogh)"
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Github Dark (Gogh)'
-- config.color_scheme = "N0Tch2K (Gogh)"
-- config.color_scheme = "Nord (Gogh)"
-- config.color_scheme = "tokyonight-storm"
-- config.color_scheme = "Tomorrow Night"
-- config.color_scheme = "Tomorrow Night (Gogh)"

-- FONTS
-- config.font = wezterm.font("JetBrainsMono NFM Medium")
-- "FiraCode Nerd Font Mono Med",
-- MesloLGS Nerd Font Mono
config.font = wezterm.font_with_fallback({
	-- "JetBrains Mono",
	-- "Atkinson Hyperlegible",
	"JetBrains Mono Medium",
	-- "JetBrains Mono SemiBold",
	-- "JetBrains Mono NL SemiBold",
	"JetBrainsMono NFM Medium",
	-- "Font Awesome 6 Free Solid",
	-- -> local function J
})
config.font_size = 17

-- from github issue, making font look closer to other terms
-- config.font.weight = "SemiBold"
-- config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
-- config.cell_width = 0.9
config.freetype_load_flags = "NO_HINTING"

-- Window Styling
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.93
-- config.text_background_opacity = 0.5
-- config.win32_system_backdrop = "Acrylic" -- NOTE: blur effect doesn't work - "Acrylic" "Mica"

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono NFM Medium" }),
	font_size = 11,
	-- active_titlebar_bg = "#333333",
	-- inactive_titlebar_bg = "#333333",
}
config.inactive_pane_hsb = {
	-- saturation = 0.8,
	brightness = 0.5,
}
-- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 60
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.colors = {
	split = "#f2d5cf",
}

-- Tab Title Styling
local nf = wezterm.nerdfonts
local TITLE_ICON = nf.md_arrow_right_bottom_bold
local LEFT_CIRCLE = nf.ple_left_half_circle_thick
local RIGHT_CIRCLE = nf.ple_right_half_circle_thick
local LEFT_DIV = nf.pl_right_hard_divider

function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

-- local function get_current_working_dir(tab)
-- 	local current_dir = tab.active_pane.current_working_dir
-- 	local HOME_DIR = string.format("file://%s", os.getenv("USERPROFILE"))
--
-- 	return current_dir == HOME_DIR and "." or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
-- end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "rgba(0% 0% 0% 0%)"
	local background = "#363a4f"
	local foreground = "#6c7086"
	local left_text = LEFT_DIV
	local right_text = RIGHT_CIRCLE
	local title = tab_title(tab)
	local mid_text = title

	if tab.is_active then
		background = "#5b6078"
		foreground = "#f2d5cf"
		left_text = LEFT_CIRCLE
		right_text = RIGHT_CIRCLE
		mid_text = TITLE_ICON .. " " .. title
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 5)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_text },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = mid_text },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = right_text },
	}
end)

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = " -- " .. name .. " " .. " -- "
	end
	window:set_left_status(name or "")
end)

-- KEYBINDS
config.keys = {
	{
		key = "Q",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- Search Mode
	{
		key = "f",
		mods = "LEADER",
		action = act.Search({ CaseInSensitiveString = "" }),
	},
	{
		key = "F",
		mods = "LEADER",
		action = act.Search({ CaseSensitiveString = "" }),
	},
	-- CopyMode (yank/visual mode)
	{
		key = "v",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},

	{
		key = "y",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	-- Split Panes
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Left",
			-- size = { Percent = 50 },
		}),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Down",
		}),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Up",
			-- size = { Percent = 50 },
		}),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			-- size = { Percent = 50 },
		}),
	},
	-- Switch/Activate Panes
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	-- Pane Resize Mode
	{

		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.QuickSelectArgs({
			patterns = {
				"https?://\\S+",
			},
		}),
	},
}

-- Key Tables
config.key_tables = {
	resize_pane = {
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },

		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },

		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- config.front_end = "OpenGL"
config.allow_win32_input_mode = false
-- and finally, return the configuration to wezterm
-- require("tabs")
return config
-- :append(require("tabs"))
