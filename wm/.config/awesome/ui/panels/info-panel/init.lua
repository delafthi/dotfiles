local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")

---@diagnostic disable
local awesome = awesome
---@diagnostic enable
--
--- Information Panel
--- ~~~~~~~~~~~~~~~~~

return function(s)
  --- Date
  local hours = wibox.widget.textclock("%I")
  local minutes = wibox.widget.textclock("%M")

  local date = {
    font = beautiful.font_bold .. beautiful.font_size_big,
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock("%A %B %d"),
  }

  local make_little_dot = function()
    return wibox.widget({
      bg = beautiful.accent,
      forced_width = dpi(7),
      forced_height = dpi(7),
      shape = gears.shape.circle,
      widget = wibox.container.background,
    })
  end

  local time = {
    {
      font = beautiful.font_bold .. beautiful.font_size_very_big,
      align = "right",
      valign = "top",
      widget = hours,
    },
    {
      nil,
      {
        make_little_dot(),
        make_little_dot(),
        spacing = dpi(7),
        widget = wibox.layout.fixed.vertical,
      },
      widget = wibox.layout.align.vertical,
      expand = "none",
    },
    {
      font = beautiful.font_bold .. beautiful.font_size_very_big,
      align = "left",
      valign = "top",
      widget = minutes,
    },
    spacing = dpi(20),
    layout = wibox.layout.fixed.horizontal,
  }

  --- Calendar
  s.calendar = require("ui.panels.info-panel.calendar")()
  local calendar = wibox.widget({
    {
      s.calendar,
      margins = dpi(16),
      widget = wibox.container.margin,
    },
    bg = beautiful.black,
    shape = helpers.ui.rrect(beautiful.border_radius),
    widget = wibox.container.background,
  })

  s.info_panel = awful.popup({
    type = "dock",
    screen = s,
    minimum_height = s.geometry.height - (beautiful.wibar_height + dpi(10)),
    maximum_height = s.geometry.height - (beautiful.wibar_height + dpi(10)),
    minimum_width = dpi(350),
    maximum_width = dpi(350),
    bg = beautiful.transparent,
    ontop = true,
    visible = false,
    placement = function(w)
      awful.placement.top_left(w)
      awful.placement.maximize_vertically(
        w,
        { honor_workarea = true, margins = { top = beautiful.useless_gap * 2 } }
      )
    end,
    widget = {
      {
        { ----------- TOP GROUP -----------
          {
            helpers.ui.vertical_pad(dpi(30)),
            {
              nil,
              time,
              expand = "none",
              layout = wibox.layout.align.horizontal,
            },
            helpers.ui.vertical_pad(dpi(20)),
            date,
            helpers.ui.vertical_pad(dpi(25)),
            layout = wibox.layout.fixed.vertical,
          },
          layout = wibox.layout.fixed.vertical,
        },
        { ----------- MIDDLE GROUP -----------
          {
            nil,
            {
              helpers.ui.vertical_pad(dpi(30)),
              {
                nil,
                calendar,
                expand = "none",
                layout = wibox.layout.align.horizontal,
              },
              layout = wibox.layout.fixed.vertical,
            },
            nil,
            layout = wibox.layout.align.vertical,
          },
          shape = helpers.ui.prrect(
            beautiful.border_radius,
            false,
            true,
            false,
            false
          ),
          bg = beautiful.lighter_black,
          widget = wibox.container.background,
        },
        {
          {
            nil,
            {
              helpers.ui.vertical_pad(dpi(30)),
              {
                nil,
                expand = "non",
                layout = wibox.layout.align.horizontal,
              },
              layout = wibox.layout.fixed.vertical,
            },
            nil,
            expand = "none",
            layout = wibox.layout.align.vertical,
          },
          shape = helpers.ui.prrect(
            beautiful.border_radius,
            false,
            true,
            false,
            false
          ),
          bg = beautiful.lighter_black,
          widget = wibox.container.background,
        },
        layout = wibox.layout.align.vertical,
      },
      shape = helpers.ui.prrect(
        beautiful.border_radius,
        false,
        true,
        false,
        false
      ),
      bg = beautiful.lighter_black,
      widget = wibox.container.background,
    },
  })

  --- Toggle container visibility
  awesome.connect_signal("info_panel::toggle", function(scr)
    if scr == s then
      s.info_panel.visible = not s.info_panel.visible
    end
  end)

  --- Toggle off container visibility
  awesome.connect_signal("info_panel::toggle_off", function(scr)
    if scr == s then
      s.info_panel.visible = false
    end
  end)
end
