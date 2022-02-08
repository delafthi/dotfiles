local M = {}
local fn = vim.fn
local keymap = vim.keymap

function M.config()
  local ok, ls = pcall(function()
    return require("luasnip")
  end)

  if not ok then
    return
  end

  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt
  local rep = require("luasnip.extras").rep
  local types = require("luasnip.util.types")

  -- Every unspecified option will be set to the default.
  ls.config.set_config({
    -- jump back into snippets
    history = true,
    -- Disable to maximize performance
    enable_autosnippets = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = { virt_text = { { "<-", "Error" } } },
      },
    },
  })

  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  ls.snippets = {
    all = {},
    markdown = {
      s(
        {
          trig = "---",
          name = "Markdown header",
          docstring = "Insert the markdown document header",
        },
        fmt(
          "---\n"
            .. "title: {}\n"
            .. "author: {}\n"
            .. "date: {}\n"
            .. "output: {}\n"
            .. "---\n"
            .. "{}",
          {
            i(1, fn.fnamemodify(fn.bufname(), ":t:r")),
            i(2, "Thierry Delafontaine"),
            i(3, fn.strftime("%d.%m.%Y")),
            i(4, fn.fnamemodify(fn.bufname(), ":t:r") .. ".pdf"),
            i(0),
          }
        )
      ),
      s(
        {
          trig = "$$",
          name = "Math array",
          docstring = "Insert a math environment",
        },
        fmt(
          "$$\n"
            .. "\\begin{{array}}{{{}}}\n"
            .. "{}\n"
            .. "\\end{{array}}\n"
            .. "$$\n"
            .. "{}",
          {
            i(1, "rcl"),
            i(2),
            i(0),
          }
        )
      ),
    },
  }

  local opts = { silent = true }
  keymap.set({ "n", "i" }, "<C-i>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, opts)
  -- Other keybindings are set in lua/config/nvim-cmp.lua
end

return M
