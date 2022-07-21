local M = {}

function M.config()
  -- Write the color definitions
  local c = require("nord.colors")

  -- Overwrite the statusline hls to prevent interference
  vim.cmd("highlight Statusline guibg=" .. c.nord0.gui)
  vim.cmd("highlight StatuslineNC guibg=" .. c.nord0.gui)

  require("feline").setup({
    components = {
      active = {
        -- Left section of statusline
        {
          {
            provider = "",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name()
                  .. "LeftCap",
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "bg",
                style = "bold",
              }
            end,
          },
          {
            provider = "vi_mode",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name(),
                fg = "black",
                bg = require("feline.providers.vi_mode").get_mode_color(),
                style = "bold",
              }
            end,
            icon = "",
          },
          {
            provider = "",
            hl = function()
              return {
                name = require("feline.providers.vi_mode").get_mode_highlight_name()
                  .. "RightCap",
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "dark_grey",
                style = "bold",
              }
            end,
          },
          {
            provider = "diagnostic_errors",
            hl = function()
              return {
                name = "StatusComponentLspErrors",
                fg = "red",
                bg = "dark_grey",
                style = "bold",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
          {
            provider = "diagnostic_warnings",
            hl = function()
              return {
                name = "StatusComponentLspWarnings",
                fg = "yellow",
                bg = "dark_grey",
                style = "bold",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
          {
            provider = "diagnostic_info",
            hl = function()
              return {
                name = "StatusComponentLspInfo",
                fg = "blue",
                bg = "dark_grey",
              }
            end,
            icon = " ",
            left_sep = "█",
          },
        },
        -- Right section of statusline
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentRightSideLeftCap",
                fg = "light_grey",
                bg = "dark_grey",
              }
            end,
          },
          {
            provider = "git_diff_added",
            hl = function()
              return {
                name = "StatusComponentGitDiffAdded",
                fg = "green",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_diff_changed",
            hl = function()
              return {
                name = "StatusComponentGitDiffChanged",
                fg = "yellow",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_diff_removed",
            hl = function()
              return {
                name = "StatusComponentGitDiffRemoved",
                fg = "red",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "git_branch",
            hl = function()
              return {
                name = "StatusComponentGitBranch",
                fg = "orange",
                bg = "light_grey",
              }
            end,
            icon = " ",
            right_sep = "█",
          },
          {
            provider = "file_info",
            hl = function()
              return {
                name = "StatusComponentFileInfo",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "file_size",
            hl = function()
              return {
                name = "StatusComponentFileSize",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentPositionLeftCap",
                fg = "blue",
                bg = "light_grey",
              }
            end,
          },
          {
            provider = "position",
            hl = function()
              return {
                name = "StatusComponentPosition",
                fg = "black",
                bg = "blue",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "line_percentage",
            hl = function()
              return {
                name = "StatusComponentLinePercentage",
                fg = "black",
                bg = "blue",
              }
            end,
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusComponentLinePercentageRightCap",
                fg = "blue",
                bg = "bg",
              }
            end,
          },
        },
      },
      inactive = {
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentEmptyLeftCap",
                fg = "dark_grey",
                bg = "bg",
              }
            end,
          },
          {
            provider = " ",
            hl = function()
              return {
                name = "StatusNCComponentEmpty",
                fg = "white",
                bg = "dark_grey",
              }
            end,
          },
        },
        {
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentPositionLeftCap",
                fg = "light_grey",
                bg = "dark_grey",
              }
            end,
          },
          {
            provider = "file_info",
            hl = function()
              return {
                name = "StatusNCComponentFileInfo",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "position",
            hl = function()
              return {
                name = "StatusNCComponentPosition",
                fg = "white",
                bg = "light_grey",
              }
            end,
            right_sep = "█",
          },
          {
            provider = "line_percentage",
            hl = function()
              return {
                name = "StatusNCComponentLinePercentage",
                fg = "white",
                bg = "light_grey",
              }
            end,
          },
          {
            provider = "",
            hl = function()
              return {
                name = "StatusNCComponentLinePercentageRightCap",
                fg = "light_grey",
                bg = "bg",
              }
            end,
          },
        },
      },
    },
    custom_providers = {},
    theme = {
      fg = c.nord4.gui,
      bg = c.nord0.gui,
      black = c.nord0.gui,
      dark_grey = c.nord1.gui,
      grey = c.nord2.gui,
      light_grey = c.nord3.gui,
      white = c.nord4.gui,
      light_white = c.nord5.gui,
      dark_blue = c.nord10.gui,
      blue = c.nord9.gui,
      skyblue = c.nord9.gui,
      light_blue = c.nord8.gui,
      cyan = c.nord7.gui,
      red = c.nord11.gui,
      orange = c.nord12.gui,
      yellow = c.nord13.gui,
      green = c.nord14.gui,
      magenta = c.nord15.gui,
      violet = c.nord15.gui,
    },
    force_inactive = {
      filetypes = {
        "^packer$",
        "^alpha$",
        "^Neogit",
        "^Telescope",
        "^help$",
      },
      buftypes = { "^terminal$" },
    },
  })
end

return M
