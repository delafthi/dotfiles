local M = {}
local u = require("utils")
local fn = vim.fn

function M.config()
  local ok, ls = pcall(function()
    return require("luasnip")
  end)

  if not ok then
    return
  end

  local s = ls.snippet
  local sn = ls.snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local c = ls.choice_node
  local d = ls.dynamic_node
  local l = require("luasnip.extras").lambda
  local r = require("luasnip.extras").rep
  local p = require("luasnip.extras").partial
  local m = require("luasnip.extras").match
  local n = require("luasnip.extras").nonempty
  local dl = require("luasnip.extras").dynamic_lambda
  local types = require("luasnip.util.types")

  -- Every unspecified option will be set to the default.
  ls.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = { virt_text = { { "choiceNode", "Comment" } } },
      },
    },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
  })

  local function copy(args)
    return args[1]
  end

  -- 'recursive' dynamic snippet. Expands to some text followed by itself.
  local rec_ls
  rec_ls = function()
    return sn(
      nil,
      c(1, {
        -- Order is important, sn(...) first would cause infinite loop of expansion.
        t(""),
        sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
      })
    )
  end

  ls.snippets = {
    all = {},
    markdown = {
      s({ trig = "$$", wordTrig = true }, {
        t({ "$$", "\\begin{array}{rcl}", "" }),
        i(1),
        t({ "", "\\end{array}", "$$", "" }),
        i(0),
      }),
    },
    sh = {
      s({ trig = "#!", worTrig = true }, {
        t({ "#!/bin/bash" }),
        i(1),
        t({ "", "", "" }),
        i(0),
      }),
    },
  }
end

return M
