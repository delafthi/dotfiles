local M = {}
local u = require("util")

function M.config()
  local ok, telescope = pcall(function()
    return require("telescope")
  end)

  if not ok then
    return
  end

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--no-heading",
        "--hidden",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = ">> ",
      selection_caret = "> ",
      entry_prefix = " ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        height = 0.8,
        width = 0.8,
        prompt_position = "top",
        preview_cutoff = 120,
        horizontal = { mirror = false, preview_width = 0.6 },
        vertical = { mirror = true },
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "%.git", "node_modules", "%.cache" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      path_display = {
        shorten = 3,
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    extensions = {
      file_browser = {
        mappings = {
          ["i"] = {
            ["<C-c>"] = telescope.extensions.file_browser.actions.create,
          },
        },
      },
      project = {
        base_dirs = {
          "~/Projects/work",
          "~/Projects/private",
        },
        hidden_files = true,
      },
    },
  })

  pcall(function()
    telescope.load_extension("fzy_native")
  end)
  pcall(function()
    telescope.load_extension("file_browser")
  end)
  pcall(function()
    telescope.load_extension("project")
  end)

  local opts = { noremap = true, silent = true }
  -- Show Telescope buffers.
  u.map(
    "n",
    "<Leader>bb",
    "<Cmd>lua require('telescope.builtin').buffers()<Cr>",
    opts
  )
  -- Search recursively in all files
  u.map(
    "n",
    "<Leader>ff",
    "<Cmd>lua require('telescope.builtin').fd({hidden=true})<Cr>",
    opts
  )
  -- Search recursively in all git files
  u.map(
    "n",
    "<Leader>fg",
    "<Cmd>lua require('telescope.builtin').git_files()<Cr>",
    opts
  )
  -- Grep a string in the workspace
  u.map(
    "n",
    "<Leader>rg",
    "<Cmd>lua require('telescope.builtin').live_grep()<Cr>",
    opts
  )
  -- Find something in the documentation
  u.map(
    "n",
    "<Leader>hh",
    "<Cmd>lua require('telescope.builtin').help_tags()<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>hk",
    "<Cmd>lua require('telescope.builtin').keymaps()<Cr>",
    opts
  )
  -- File browser
  u.map(
    "n",
    "<Leader>fb",
    "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<Cr>",
    opts
  )
  -- Git
  u.map(
    "n",
    "<Leader>gs",
    "<Cmd>lua require('telescope.builtin').git_status()<Cr>",
    opts
  )

  -- Projects
  u.map(
    "n",
    "<Leader>pp",
    "<Cmd>lua require('telescope').extensions.project.project{}<Cr>",
    opts
  )
end

return M
