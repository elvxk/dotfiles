local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- default shell
config.default_prog = { "pwsh", "-nologo" }
-- config.default_prog = { "wsl", "-d", "Ubuntu" }
-- config.default_prog = { "D:\\Git\\bin\\bash.exe", "-l" }

-- colorscheme
config.color_scheme = "Catppuccin Mocha"

-- tab
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

wezterm.on("format-tab-title", function(tab)
	local title = " Kirby [" .. tab.tab_index + 1 .. "] "
	return title
end)

-- font
config.font = wezterm.font_with_fallback({
	{ family = "FiraCode Nerd Font Mono" },
})
config.font_size = 18

--window
config.window_decorations = "RESIZE"
config.initial_cols = 120
config.initial_rows = 30
config.default_cursor_style = "BlinkingBar"
config.window_background_opacity = 0.9

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}
-- keymaps
config.keys = {
	{
		key = ">",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "<",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "x",
		mods = "CTRL|ALT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "f",
		mods = "CTRL|ALT",
		action = wezterm.action.ToggleFullScreen,
	},
}

return config
