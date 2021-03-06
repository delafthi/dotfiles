-- awesome_mode: api-level=4:screen=on
--------------------------------------------------------------------------------
-- {{{ Includes

pcall(require, 'luarocks.loader')
-- Standard awesome libraries
local gears = require('gears') -- Utilities such as color parsing and objects
local awful = require('awful') -- Everything related to window management
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox') -- Awesome own generic widget framework
-- Theme handling library
local beautiful = require('beautiful') -- Awesome theme module
-- Nofification library
local naughty = require('naughty') -- Notifications
-- Declarative object management
local ruled = require('ruled')
local hotkeys_popup = require('awful.hotkeys_popup')
-- Custom layout
local twopane = require('layouts.twopane')

-- }}}
--------------------------------------------------------------------------------
-- {{{ Error handling

-- Check if awesome ecountered an error during startup and fell back to another
-- config
naughty.connect_signal('request::display_error', function(message, startup)
  naughty.notification {
    urgency = 'critical',
    title ='Oops, an error happened' .. (startup and ' during startup!' or '!'),
    message = message
  }
end)

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = 'Oops, an error happened!',
      text = tostring(err)
    })
    in_error = false
  end)
end

-- }}}
--------------------------------------------------------------------------------
-- {{{ Variable definitions

-- Default applications
terminal = 'kitty'
browser = 'brave'
filemanager = 'pcmanfm'
editor = os.getenv('EDITOR') or 'nvim'
editor_cmd = terminal .. ' -e ' .. editor
mydmenu_run =  function()
  local gap = 2 * beautiful.useless_gap
  local screen = awful.screen.focused()
  local x_offset = ' -x ' .. screen.geometry['x'] + gap
  local y_offset = ' -y ' .. screen.geometry['y'] + gap
  local width = ' -z ' .. screen.geometry['width'] - 2 * gap
  local height = ' -h ' .. beautiful.wibox_height
  return 'dmenu_run -p "Run: "' .. x_offset .. y_offset .. width .. height
end

-- Default mod key
modkey = 'Mod4'

-- Initialize theme
beautiful.init(gears.filesystem.get_configuration_dir() .. 'themes/onedark/theme.lua')

-- Table of layouts
tag.connect_signal('request::default_layouts', function()
  awful.layout.append_default_layouts {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    twopane,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
  }
end)

-- }}}
--------------------------------------------------------------------------------
-- {{{ Widgets

-- Launcher menu
mymenu = awful.menu {
  items = {
    { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
    { 'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { 'restart', function() awesome.restart() end },
    { 'quit', function() awesome.quit() end }
  }
}

-- Launcher widget
mylauncher = wibox.widget {
  {
    image = beautiful.awesome_icon,
    resize = true,
    widget = wibox.widget.imagebox,
  },
  top = 4,
  right = 6,
  left = 8,
  bottom = 4,
  widget = wibox.container.margin,
  buttons = {
    awful.button({ }, 1,
      function() awful.spawn(mydmenu_run()) end
    ),
    awful.button({ }, 3,
      function() mymenu:toggle() end
    )
  },
}

-- Taglist widget
local mytaglist = function(s)
  local taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end),
    },
    layout = {
      spacing = 4,
      spacing_widget = {
        {
          forced_width =  0,
          color = beautiful.wibox_bg,
          widget = wibox.widget.separator,
        },
        valign = 'center',
        halign = 'center',
        widget = wibox.container.place,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        id = 'text_role',
        widget = wibox.widget.textbox,
      },
      left = 6,
      right = 6,
      widget = wibox.container.margin,
    },
    id = 'background_role',
    widget = wibox.container.background,
  }
  return taglist
end

-- Layout widget
local mylayoutbox = function(s)
  local layoutbox = wibox.widget {
    {
      id = 'layoutbox_role',
      awful.widget.layoutbox {
        screen = s,
        buttons = {
          awful.button({ }, 1, function() awful.layout.inc(1) end),
          awful.button({ }, 4, function() awful.layout.inc(1) end),
          awful.button({ }, 5, function() awful.layout.inc(-1) end)
        },
      },
      opacity = 0.24,
      layout = wibox.layout.fixed.horizontal,
    },
    top = 6,
    right = 6,
    left = 6,
    bottom = 4,
    widget = wibox.container.margin,
  }
  return layoutbox
end

-- Tasklist widget
local mytasklist = function(s)
  local tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    tasklist_plain_task_name = true,
    buttons = {
      awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
      end),
      awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
      awful.button({ }, 5, function() awful.client.focus.byidx(-1) end),
    },
    layout = {
      spacing = 1,
      spacing_widget = {
        {
          forced_width =  3,
          color = beautiful.wibox_separator_fg,
          widget = wibox.widget.separator,
        },
        valign = 'center',
        halign = 'center',
        widget = wibox.container.place,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          {
            {
              id = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            top = 4,
            right = 4,
            bottom = 4,
            widget = wibox.container.margin,
          },
          {
            id = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left = 6,
        right = 6,
        widget = wibox.container.margin,
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
  }
  return tasklist
end

-- CPU info widget
local cpus = {}
mycpuinfo = wibox.widget {
  {
    id = 'watch_role',
    awful.widget.watch([[bash -c 'grep '^cpu.' /proc/stat']], 1,
      function(widget, stdout)
        for line in stdout:gmatch('[^\r\n]+') do
          if line:sub(1, #'cpu') == 'cpu' then
            local name, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
              line:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')
            local total = user + nice + system + idle + iowait + irq + softirq + steal

            if cpus[name] == nil then cpus[name] = {} end
            local diff_idle = idle - tonumber(cpus[name]['idle_prev'] == nil and 0 or cpus[name]['idle_prev'])
            local diff_total = total - tonumber(cpus[name]['total_prev'] == nil and 0 or cpus[name]['total_prev'])
            cpus[name]['diff_usage'] = ((diff_total - diff_idle) / diff_total)*100

            cpus[name]['total_prev'] = total
            cpus[name]['idle_prev'] = idle
          end
        end
        widget:set_markup_silently(string.format('<span color=%q> :%3.f%%</span>',
          beautiful.red, cpus['cpu']['diff_usage']))
      end),
    layout = wibox.layout.fixed.horizontal,
  },
  right = 6,
  left = 6,
  widget = wibox.container.margin,
}

-- Mem info widg
local mem = {}
mymeminfo = wibox.widget {
  {
    id = 'watch_role',
    awful.widget.watch([[bash -c 'grep '^Mem.' /proc/meminfo']], 1,
      function(widget, stdout)
        for line in stdout:gmatch('[^\r\n]+') do
          if line:sub(1, #'Mem') == 'Mem' then
            local name, number, _ = line:match('(%w+):%s+(%d+)%s(%w+)')
            mem[name] = number
          end
        end
        mem['MemUsed'] = tonumber(mem['MemTotal'] == nil and 0 or mem['MemTotal']) - tonumber(mem['MemAvailable'] == nil and 0 or mem['MemAvailable'])
        widget:set_markup_silently(string.format('<span color=%q> : %3.f%%</span>', beautiful.yellow, mem['MemUsed']/mem['MemTotal']*100))
      end),
    layout = wibox.layout.fixed.horizontal,
  },
  right = 6,
  left = 6,
  widget = wibox.container.margin,
}

-- Clock
mytextclock = wibox.widget {
  {
    format = '<span color="' .. beautiful.purple .. '"> : %a %d. %b %Y %H:%M</span>',
    widget = wibox.widget.textclock,
  },
  right = 6,
  left = 6,
  widget = wibox.container.margin,
}

mysystray = wibox.widget {
  {
    widget = wibox.widget.systray,
  },
  right = 6,
  widget = wibox.container.margin,
}

-- Default separator
myseparator = {
  color = beautiful.wibox_separator_fg,
  forced_width = 1,
  widget = wibox.widget.separator
}

-- }}}
--------------------------------------------------------------------------------
-- {{{ Wibox


local function set_wibox(s)
  local gap = 2 * beautiful.useless_gap
  -- Create screen specific widgets
  s.mytaglist = mytaglist(s)
  s.mylayoutbox = mylayoutbox(s)
  s.mytasklist = mytasklist(s)
  -- Remove old wibox
  if s.mywibox ~= nil then s.mywibox.visible = false end
  -- Create wibox
  s.mywibox = wibox {
    visible = true,
    opacity = 1.0,
    type = 'dock',
    x = s.geometry['x'] + gap,
    y = s.geometry['y'] + gap,
    width = s.geometry['width'] - 2 * gap,
    height = beautiful.wibox_height,
    screen = s,
    bg = beautiful.wibox_bg,
    fg = beautiful.wibox_fg,
  }
  -- Set wibox struts
  s.mywibox:struts {
    top = 28,
    right = 0,
    left = 0,
    bottom = 0,
  }
  -- Add widgets to the wibox
  s.mywibox:setup {
    { -- Left widgets
      mylauncher,
      s.mytaglist,
      s.mylayoutbox,
      wibox.widget.separator {
        forced_width = 0,
        color = beautiful.wibox_bg,
      },
      spacing = 1,
      spacing_widget = myseparator,
      layout = wibox.layout.fixed.horizontal(),
    },
    {-- Middle widgets
      s.mytasklist,
      spacing = 1,
      spacing_widget = myseparator,
      layout = wibox.layout.fixed.horizontal
    },
    { -- Right widgets
      mycpuinfo,
      mymeminfo,
      mytextclock,
      mysystray,
      spacing = 1,
      spacing_widget = myseparator,
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end

-- }}}
--------------------------------------------------------------------------------
-- {{{ Create environment

local function set_random_wallpaper(s)
  local wallpaper_path = beautiful.wallpapers_path
  local fileending = beautiful.wallpapers_fileending
  local f = io.popen('fd -d 1 --regex ' .. fileending .. ' ' ..  wallpaper_path, 'r')
  local files = {}
  local length = 0
  local line = 'begin'
  while line ~= nil do
    line = f:read('*l')
    table.insert(files, line)
    length = length + 1
  end
  f:close()
  math.randomseed(os.time()) -- Set the random seed
  math.random(); math.random(); math.random() -- Pop some random numbers, before using it
  return gears.wallpaper.maximized(files[math.random(1, length)], s, true)
end

screen.connect_signal('request::wallpaper', function(s)
  if beautiful.wallpapers_path and beautiful.wallpapers_fileending then
    set_random_wallpaper(s)
  end
end)

screen.connect_signal('request::desktop_decoration', function(s)
  -- Create taglist
  -- Each screen has its own tag table
  awful.tag({ 'www', 'dev', 'sys', 'chat', 'mus', 'virt', 'doc', 'vis'}, s,
    awful.layout.layouts[1])
  -- Re/set wibox
  set_wibox(s)
end)

-- }}}
--------------------------------------------------------------------------------
-- {{{ Key bindings

-- General Awesome keybinings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey,           }, 'Escape',
    function() awful.spawn('slock') end,
    {description = 'lock the session', group = 'awesome'}
  ),
  awful.key({ modkey, 'Control' }, 'q',
    function() awesome.quit() end,
    {description = 'quit awesome', group = 'awesome'}
  ),
  awful.key({ modkey, 'Shift'   }, 'q',
    function () awesome.restart() end,
    {description = 'restart awesome', group = 'awesome'}
  ),
  awful.key({ modkey, 'Shift'   }, 'slash',
    function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
    {description = 'display help', group = 'awesome'}
  ),
  awful.key({ modkey,           }, 'Return',
    function() awful.spawn(terminal) end,
    {description = 'open a terminal', group = 'launcher'}
  ),
  awful.key({ modkey,           }, 's',
    function() awful.spawn(terminal) end,
    {description = 'open a scratchpad terminal', group = 'launcher'}
  ),
  awful.key({ modkey, 'Shift'   }, 'Return',
    function() awful.spawn(mydmenu_run()) end,
    {description = 'open dmenu', group = 'launcher'}
  ),
  awful.key({ modkey,           }, 'b',
    function() awful.spawn(browser) end,
    {description = 'open a browser', group = 'launcher'}
  ),
  awful.key({ modkey,           }, 'f',
    function() awful.spawn(filemanager) end,
    {description = 'open a file manager', group = 'launcher'}
  ),
}

-- Layout related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey,           }, 'space',
    function()
      local screen = awful.screen.focused()
      awful.layout.inc(1, screen)
    end,
    {description = 'next layout', group = 'layout'}
  ),
  awful.key({ modkey, 'Shift'   }, 'space',
    function()
      local screen = awful.screen.focused()
      awful.layout.inc(-1, screen)
    end,
    {description = 'previous layout', group = 'layout'}
  ),
  awful.key({ modkey,           }, 'h',
    function() awful.tag.incmwfact(-0.03, nil) end,
    {description = 'minmize the master pane', group = 'layout'}
  ),
  awful.key({ modkey,           }, 'l',
    function() awful.tag.incmwfact(0.03, nil) end,
    {description = 'maximize the master pane', group = 'layout'}
  ),
  awful.key({ modkey,           }, 'comma',
    function() awful.tag.incnmaster(-1, nil, true) end,
    {description = 'decrease number of master clients', group = 'layout'}
  ),
  awful.key({ modkey,           }, 'period',
    function() awful.tag.incnmaster(1, nil, true) end,
    {description = 'increase number of master clients', group = 'layout'}
  ),
}

-- Tag  related key bindings
for i = 1, 8 do
  awful.keyboard.append_global_keybindings {
    -- View tag only
    awful.key({ modkey,           }, '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = 'switch to tag ' .. awful.screen.focused().tags[i].name, group = 'tag'}
    ),
    -- Toggle tag display
    awful.key({ modkey, 'Shift'   }, '#' .. i + 9,
      function()
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end,
      {description = 'move client to tag ' .. awful.screen.focused().tags[i].name, group = 'tag'}
    ),
  }
end


-- Focus related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey,           }, 'Tab',
    function() awful.client.focus.byidx(1) end,
    {description = 'focus next client', group = 'client'}
  ),
  awful.key({ modkey, 'Shift'   }, 'Tab',
    function() awful.client.focus.byidx(-1) end,
    {description = 'focus previous client', group = 'client'}
  ),
  awful.key({ modkey,           }, 'j',
    function() awful.client.focus.byidx(1) end,
    {description = 'focus next client', group = 'client'}
  ),
  awful.key({ modkey,           }, 'k',
    function() awful.client.focus.byidx(-1) end,
    {description = 'focus previous client', group = 'client'}
  ),
  awful.key({ modkey, 'Shift'   }, 'j',
    function() awful.client.swap.byidx(1) end,
    {description = 'swap with next client', group = 'client'}
  ),
  awful.key({ modkey, 'Shift'   }, 'k',
    function() awful.client.swap.byidx(-1) end,
    {description = 'swap with previous client', group = 'client'}
  ),
}

-- Screen related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ modkey,           }, 'w',
    function()
      awful.screen.focus_bydirection('left', awful.screen.focused())
    end,
    {description = 'focus left screen', group = 'screen'}
  ),
  awful.key({ modkey,           }, 'e',
    function()
      awful.screen.focus_bydirection('right', awful.screen.focused())
    end,
    {description = 'focus right screen', group = 'screen'}
  ),
}

-- Volume control keybindings
awful.keyboard.append_global_keybindings {
  awful.key({                   }, 'XF86AudioRaiseVolume',
    function()
      os.execute(string.format('amixer -c 0 sset Master 5+ unmute'))
    end,
    {description = 'raise volume', group = 'system'}
    ),
  awful.key({                   }, 'XF86AudioLowerVolume',
    function()
      os.execute(string.format('amixer -c 0 sset Master 5- unmute'))
    end,
    {description = 'lower volume', group = 'system'}
    ),
  awful.key({                   }, 'XF86AudioMute',
    function()
      os.execute(string.format('amixer set Master toggle'))
    end,
    {description = 'mute volume', group = 'system'}
  ),
}

-- Set client related key bindings
client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings {
    awful.key({ modkey,           }, 'q',
      function(c) c:kill() end,
      {description = 'kill the current client', group = 'client'}
    ),
    awful.key({ modkey,           }, 'm',
      function(c) awful.client.setmaster(c) end,
      {description = 'set the current client as master', group = 'client'}
    ),
    awful.key({ modkey, 'Shift'   }, 'm',
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = 'toggle fullscreen mode for the current client', group = 'client'}
    ),
    awful.key({ modkey,           }, 'p',
      function(c)
        c.floating = not c.floating
        c:raise()
      end,
      {description = 'toggle floating for the current client', group = 'client'}
    ),
    awful.key({ modkey, 'Shift'   }, 'w',
      function(c)
        c:move_to_screen(c.screen.index - 1)
      end,
      {description = 'move focused client to the left screen', group = 'client'}
    ),
    awful.key({ modkey, 'Shift'   }, 'e',
      function(c)
        c:move_to_screen(c.screen.index + 1)
      end,
      {description = 'move focused client to the right screen', group = 'client'}
    ),
  }
end)

--- }}}
--------------------------------------------------------------------------------
-- {{{ Mouse bindings

client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings {
    awful.button({        }, 1,
      function(c)
        client.focus = c
        c:raise()
      end
    ),
    awful.button({ modkey }, 1,
      function(c)
        c.floating = true
        c:raise()
        awful.mouse.client.move(c)
      end
    ),
    awful.button({ modkey }, 3,
      function(c)
        c.floating = true
        c:raise()
        awful.mouse.client.resize(c)
      end
    ),
  }
end)

-- }}}
--------------------------------------------------------------------------------
-- {{{ Client rules

-- All new appearing clients will match these rules
ruled.client.connect_signal('request::rules', function()
  -- All clients
  ruled.client.append_rule {
    id = 'global',
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }
  -- Floating clients
  ruled.client.append_rule {
    id = 'floating',
    rule_any = {
      class = {
        'Pavucontrol',
        'Xmessage'
      },
      type= {
        'dialog'
      }
    },
    properties = { floating = true }
  }
end)

-- }}}
--------------------------------------------------------------------------------
-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
  -- All notifications
  ruled.notification.append_rule {
    rule = { },
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  }
end)

naughty.connect_signal('request::display', function(n)
  naughty.layout.box { notification = n }
end)

-- }}}
--------------------------------------------------------------------------------
-- {{{ Signals

-- Focus signals
client.connect_signal('focus', function(c)
  c.skip_taskbar = false
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.skip_taskbar = true
  if c.floating == true then
      c.border_color = beautiful.border_floating
    else
      c.border_color = beautiful.border_normal
  end
end)

-- }}}
