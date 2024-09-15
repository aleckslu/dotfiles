local wezterm = require("wezterm")
local symbols = require("wezterm").nerdfonts

local colors = { -- Dracula+
	foreground = "#f8f8f2",
	background = "#212121",

	cursor_bg = "#ECEFF4",
	cursor_fg = "#0E1415",
	cursor_border = "#f8f8f2",

	selection_fg = "none",
	selection_bg = "rgba(68,71,90,0.5)",

	scrollbar_thumb = "#44475a",
	split = "#6272a4",

	ansi = { "#21222C", "#FF5555", "#50FA7B", "#FFCB6B", "#BD93F9", "#FF79C6", "#8BE9FD", "#BBBBBB" },
	brights = { "#545454", "#FF6E6E", "#69FF94", "#F1FA8C", "#D6ACFF", "#FF92DF", "#A4FFFF", "#FFFFFF" },

	indexed = {
		-- might need to change this
		[16] = "#FFFFFF",
		[17] = "#BBBBBB",
	},
}

-- Setting the tabs
local tabs = {}

-- Strips basename from a file path (E.g.: /cat/dog becomes dog) and
-- strip the executable extension
local function stripbase(path)
	local new_path = string.gsub(path, "(.*[/\\])(.*)", "%2")
	return new_path:gsub("%.exe$", "")
end

-- Tab separator icons
local FIRST_TAB_LEFT_SIDE = "█"
local TAB_LEFT_SIDE = symbols.ple_left_half_circle_thick
local TAB_RIGHT_SIDE = symbols.ple_right_half_circle_thick

-- Running process icons
local CMD_ICON = symbols.cod_terminal_cmd
local PS_ICON = symbols.cod_terminal_powershell
local BASH_ICON = symbols.cod_terminal_bash
local WSL_ICON = symbols.cod_terminal_linux
local HOURGLASS_ICON = symbols.fa_hourglass_half
local NVIM_ICON = symbols.custom_vim

-- Default colors
local BACKGROUND_COLOR = colors.background
local FOREGROUND_COLOR = colors.foreground
local EDGE_COLOR = colors.background
local DIM_COLOR = colors.background

function tabs.setup()
	-- Decorate the tab bar with icons based on the running shell/application and its state
	wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
		if tab.is_active then
			BACKGROUND_COLOR = colors.ansi[5]
			FOREGROUND_COLOR = colors.ansi[1]
		elseif hover then
			BACKGROUND_COLOR = colors.brights[4]
			FOREGROUND_COLOR = colors.ansi[1]
		else
			BACKGROUND_COLOR = colors.selection_bg
			FOREGROUND_COLOR = colors.selection_fg
		end

		local edge_foreground = BACKGROUND_COLOR
		local process_name = tab.active_pane.foreground_process_name
		local exec_name = stripbase(process_name)
		local title_with_icon = ""

		-- Select an appropriate icon
		if exec_name == "pwsh" then
			title_with_icon = PS_ICON .. " PS"
		elseif exec_name == "cmd" then
			title_with_icon = CMD_ICON .. " CMD"
		elseif exec_name == "wsl" or exec_name == "wslhost" then
			title_with_icon = WSL_ICON .. " WSL"
		elseif exec_name == "bash" then
			title_with_icon = BASH_ICON .. " BASH"
		elseif exec_name == "nvim" then
			title_with_icon = NVIM_ICON .. " NVIM"
		else
			title_with_icon = HOURGLASS_ICON .. " " .. exec_name
		end

		-- Identify tab number with a numeral
		local id = string.format("%s", tab.tab_index + 1)

		-- Trim long titles
		local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 5) .. " "

		return {
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = EDGE_COLOR } },
			{ Foreground = { Color = edge_foreground } },
			{ Text = tab.tab_index == 0 and FIRST_TAB_LEFT_SIDE or TAB_LEFT_SIDE },
			{ Background = { Color = BACKGROUND_COLOR } },
			{ Foreground = { Color = FOREGROUND_COLOR } },
			{ Text = id },
			{ Text = title },
			{ Foreground = { Color = DIM_COLOR } },
			{ Background = { Color = EDGE_COLOR } },
			{ Foreground = { Color = edge_foreground } },
			{ Text = TAB_RIGHT_SIDE },
			{ Attribute = { Intensity = "Normal" } },
		}
	end)
end

return {
	-- Font settings
	-- font = wezterm.font("JetBrainsMono Nerd Font"),
	-- font_size = 11,
	freetype_interpreter_version = 40,
	unicode_version = 14,
	harfbuzz_features = { "calt=1", "liga=1", "clig=1", "dlig=1" },
	warn_about_missing_glyphs = false,

	-- reason: https://github.com/DerekSauer/wezterm-config/blob/1529c3157c13c508005547e9a8513ab688361b8a/wezterm.lua#L22
	-- front_end = "OpenGL",

	-- Window size and theming
	colors = {
		foreground = colors.foreground,
		background = colors.background,

		cursor_bg = colors.cursor_bg,
		cursor_fg = colors.cursor_fg,
		cursor_border = colors.cursor_border,

		selection_fg = colors.selection_fg,
		selection_bg = colors.selection_bg,

		scrollbar_thumb = colors.scrollbar_thumb,
		split = colors.split,

		ansi = colors.ansi,
		brights = colors.brights,
		indexed = colors.indexed,

		tab_bar = {
			background = colors.background,
			new_tab = {
				bg_color = colors.background,
				fg_color = colors.foreground,
				intensity = "Bold",
			},
			new_tab_hover = {
				bg_color = colors.background,
				fg_color = colors.foreground,
				italic = true,
				intensity = "Bold",
			},
		},
	},
	initial_cols = 120,
	initial_rows = 32,
	audible_bell = "Disabled",
	scrollback_lines = 1000,
	force_reverse_video_cursor = true,
	enable_scroll_bar = false,
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	default_cursor_style = "BlinkingUnderline",
	default_prog = { "powershell.exe" },

	-- Tabbar
	-- hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_max_width = 60,

	-- Window
	window_decorations = "INTEGRATED_BUTTONS | RESIZE",
	adjust_window_size_when_changing_font_size = false,
	integrated_title_button_style = "Windows",
	integrated_title_button_color = "auto",
	integrated_title_button_alignment = "Right",
	window_close_confirmation = "AlwaysPrompt",

	-- Keys
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,

	-- Visual bell, flare the cursor
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	tabs.setup(),

	hyperlink_rules = {
		{ -- Linkify things that look like URLs
			regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		{ -- match the URL with a PORT such 'http://localhost:3000/index.html'
			regex = "\\b\\w+://(?:[\\w.-]+):\\d+\\S*\\b",
			format = "$0",
		},
		{ -- linkify email addresses
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},
		{ -- file:// URI
			regex = "\\bfile://\\S*\\b",
			format = "$0",
		},
	},
}
