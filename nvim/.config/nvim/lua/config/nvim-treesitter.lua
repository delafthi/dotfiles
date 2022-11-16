local M = {}

function M.config()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
  -- VHDL
  parser_configs.vhdl = {
    install_info = {
      url = "https://github.com/alemuller/tree-sitter-vhdl",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = { "vhdl", "vhd" },
  }

  -- Call the setup function
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grp",
      },
    },

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
        swap_next = { ["<Leader>as"] = "@parameter.inner" },
        swap_previous = { ["<Leader>aS"] = "@parameter.inner" },
      },
      move = {
        enable = true,
        set_jumps = false, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = { query = "@function.outer", desc = "Next function start" },
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
        },
        goto_next_end = {
          ["]M"] = { query = "@function.outer", desc = "Next function end" },
          ["]["] = { query = "@class.outer", desc = "Next class end" },
        },
        goto_previous_start = {
          ["[m"] = { query = "@function.outer", desc = "Previous function start" },
          ["[["] = { query = "@class.outer", desc = "Previous class start" },
        },
        goto_previous_end = {
          ["[M"] = { query = "@function.outer", desc = "Previous function end" },
          ["[]"] = { query = "@class.outer", desc = "Previous class end" },
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<C-g>f"] = "@function.outer",
          ["<C-g>c"] = "@class.outer",
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  })
end

return M
