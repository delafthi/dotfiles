local M = {}

function M.config()
  local ok, ts = pcall(function()
    return require("nvim-treesitter.configs")
  end)

  if not ok then
    return
  end

  ts.setup({
    ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = { enable = false },

    -- Treesitter Plugins
    context_commentstring = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<Leader>a"] = "@parameter.inner" },
        swap_previous = { ["<Leader>A"] = "@parameter.inner" },
      },
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          --  ["df"] = "@function.outer",
          --  ["dF"] = "@class.outer",
        },
      },
    },
  })
end

return M
