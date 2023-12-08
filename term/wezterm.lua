local wezterm = require 'wezterm'

return {
  font = wezterm.font "JetBrains Mono",
  font_size = 14,
  color_scheme = "tokyonight-storm",
  window_decorations = "RESIZE",
  -- default_cursor_style = 'BlinkingBlock',
  keys = {
    { key = "[", mods = "OPT|SUPER", action = wezterm.action.MoveTabRelative(-1) },
    { key = "]", mods = "OPT|SUPER", action = wezterm.action.MoveTabRelative(1) },
  },
  hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },
    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },
  }
}

