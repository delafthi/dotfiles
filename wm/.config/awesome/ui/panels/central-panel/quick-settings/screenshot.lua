local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local widgets = require("ui.widgets")
local apps = require("config.apps")

---@diagnostic disable
local awesome = awesome
---@diagnostic enable

--- Screenshot Widget
--- ~~~~~~~~~~~~~~~~~

local screenshot = {}

local function button(icon, command)
  return widgets.button.text.normal({
    forced_width = dpi(60),
    forced_height = dpi(60),
    normal_bg = beautiful.lighter_black,
    normal_shape = gears.shape.circle,
    on_normal_bg = beautiful.accent,
    text_normal_bg = beautiful.accent,
    text_on_normal_bg = beautiful.black,
    font = beautiful.font,
    size = beautiful.font_size_big,
    text = icon,
    on_release = function()
      awesome.emit_signal("central_panel::toggle", awful.screen.focused())
      gears.timer({
        timeout = 1,
        autostart = true,
        single_shot = true,
        callback = function()
          awful.spawn.with_shell(command)
        end,
      })
    end,
  })
end

screenshot.area = button(" ", apps.utils.area_screenshot)
screenshot.full = button(" ", apps.utils.full_screenshot)

return screenshot