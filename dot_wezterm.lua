local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Custom One Dark Pro Night Flat Color Scheme
config.color_schemes = {
  ['One Dark Pro Night Flat'] = {
    foreground = '#abb2bf',
    background = '#16191d',
    cursor_bg = '#ffffff', -- Blue cursor
    cursor_fg = '#16191d',
    cursor_border = '#ffffff',
    selection_bg = '#323842',
    selection_fg = '#d7dae0',
    ansi = {
      '#282c34', -- 0: black
      '#be5046', -- 1: red (Dark Red)
      '#98c379', -- 2: green
      '#d19a66', -- 3: yellow (Dark Yellow)
      '#61afef', -- 4: blue
      '#c678dd', -- 5: magenta
      '#56b6c2', -- 6: cyan
      '#abb2bf', -- 7: white
    },
    brights = {
      '#5c6370', -- 8: bright black (Comment Grey)
      '#e06c75', -- 9: bright red (Light Red)
      '#b5e28c', -- 10: bright green (lighter shade of green #98c379)
      '#e5c07b', -- 11: bright yellow (Light Yellow)
      '#7ec2ff', -- 12: bright blue (lighter shade of blue #61afef)
      '#d68fed', -- 13: bright magenta (lighter shade of magenta #c678dd)
      '#6cd8e6', -- 14: bright cyan (lighter shade of cyan #56b6c2)
      '#ffffff', -- 15: bright white
    },
    tab_bar = {
      background = '#16191d',
      active_tab = {
        bg_color = '#23272e',
        fg_color = '#dcdcdc',
        intensity = 'Bold',
      },
      inactive_tab = {
        bg_color = '#16191d',
        fg_color = '#abb2bf',
      },
      inactive_tab_hover = {
        bg_color = '#323842',
        fg_color = '#d7dae0',
      },
      new_tab = {
        bg_color = '#16191d',
        fg_color = '#abb2bf',
      },
      new_tab_hover = {
        bg_color = '#323842',
        fg_color = '#d7dae0',
      },
    }
  }
}

config.color_scheme = 'One Dark Pro Night Flat'

-- Background Image Configuration
config.background = {
  -- Layer 1: Solid Dark Color (prevent desktop transparency - using One Dark Pro Night Flat background)
  {
    source = {
      Color = '#16191d',
    },
    width = '100%',
    height = '100%',
    opacity = 1.0,
  },
  -- Layer 2: Wallpaper image blended on top
  {
    source = {
      File = wezterm.home_dir .. '/Pictures/wallpaper/106850359_p0.png',
    },
    repeat_x = 'NoRepeat',
    repeat_y = 'NoRepeat',
    width = 'Cover',
    height = 'Cover',
    opacity = 0.2, -- Blend opacity on top of solid color
    hsb = {
      brightness = 0.08, -- Darkened for text readability
      saturation = 0.8,
    }
  }
}

-- Font Configuration
config.font = wezterm.font_with_fallback {
  { family = 'JetBrains Mono', weight = 'Regular' },
  { family = 'Fira Code', weight = 'Regular' },
  { family = 'Hack', weight = 'Regular' },
  { family = 'Menlo', weight = 'Regular' },
  { family = 'SF Mono', weight = 'Regular' },
}
config.font_size = 14.0

-- Default Window Size on Startup (Width x Height in character cells)
config.initial_cols = 120
config.initial_rows = 35

-- Styling and Aesthetics (Solid background, no transparency/blur)
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

-- Window decorations (native macOS title bar for smooth dragging)
config.window_decorations = "TITLE|RESIZE"
config.use_fancy_tab_bar = true -- Modern tab design with close buttons
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Customize fancy tab bar frame background to blend with terminal color
config.window_frame = {
  active_titlebar_bg = '#16191d',
  inactive_titlebar_bg = '#16191d',
}

-- Zellij-like KeyTables & Modal Bindings
config.keys = {
  -- Ctrl + p to enter PANE mode (one_shot = false to allow multiple navigation presses)
  {
    key = 'p',
    mods = 'CTRL',
    action = wezterm.action.ActivateKeyTable { name = 'pane', one_shot = false }
  },
  -- Ctrl + t to enter TAB mode (one_shot = false to allow multiple navigation presses)
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action.ActivateKeyTable { name = 'tab', one_shot = false }
  },
}

config.key_tables = {
  pane = {
    -- New pane down (split vertically) - one shot (exits pane mode)
    {
      key = 'd',
      action = wezterm.action.Multiple {
        wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        wezterm.action.PopKeyTable
      }
    },
    -- New pane right (split horizontally) - one shot (exits pane mode)
    {
      key = 'n',
      action = wezterm.action.Multiple {
        wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        wezterm.action.PopKeyTable
      }
    },
    {
      key = 'r',
      action = wezterm.action.Multiple {
        wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        wezterm.action.PopKeyTable
      }
    },
    -- Close current pane - one shot (exits pane mode)
    {
      key = 'x',
      action = wezterm.action.Multiple {
        wezterm.action.CloseCurrentPane { confirm = true },
        wezterm.action.PopKeyTable
      }
    },
    -- Navigation (Vim style & Arrows) - persistent (allows repeating, exit with Enter/Esc)
    { key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'LeftArrow', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'DownArrow', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'UpArrow', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },
    -- Exit pane mode (Escape, Enter, or Ctrl+p again)
    { key = 'Escape', action = wezterm.action.PopKeyTable },
    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'p', mods = 'CTRL', action = 'PopKeyTable' },
  },
  tab = {
    -- New tab - one shot (exits tab mode)
    {
      key = 'n',
      action = wezterm.action.Multiple {
        wezterm.action.SpawnTab 'CurrentPaneDomain',
        wezterm.action.PopKeyTable
      }
    },
    -- Tab navigation (Vim style & Arrows) - persistent (allows repeating, exit with Enter/Esc)
    { key = 'h', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'l', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'LeftArrow', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'RightArrow', action = wezterm.action.ActivateTabRelative(1) },
    -- Close tab - one shot (exits tab mode)
    {
      key = 'x',
      action = wezterm.action.Multiple {
        wezterm.action.CloseCurrentTab { confirm = true },
        wezterm.action.PopKeyTable
      }
    },
    -- Exit tab mode (Escape, Enter, or Ctrl+t again)
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
    { key = 't', mods = 'CTRL', action = 'PopKeyTable' },
  },
}

-- Render active mode in status bar
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'MODE: ' .. string.upper(name)
    window:set_right_status(wezterm.format {
      { Background = { Color = '#4d78cc' } },
      { Foreground = { Color = '#ffffff' } },
      { Text = '  ' .. name .. '  ' },
    })
  else
    window:set_right_status('')
  end
end)

-- Return the configuration
return config
