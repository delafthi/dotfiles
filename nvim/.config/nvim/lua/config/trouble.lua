local M = {}
local u = require("util")

function M.config()
  local ok, trouble = pcall(function()
    return require("trouble")
  end)

  if not ok then
    return
  end

  trouble.setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- 'workspace_diagnostics', 'document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
      close = "q", -- close the list
      cancel = { "<Esc>", "<C-c>" }, -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<Cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between 'workspace' and 'document' diagnostics mode
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small poup with the full multiline message
      preview = "p", -- preview the diagnostic location
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- preview item
      next = "j", -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  })

  local opts = { noremap = true, silent = true }
  u.map("n", "<Leader>xx", "<Cmd>TroubleToggle<Cr>", opts)
  u.map("n", "<Leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<Cr>", opts)
  u.map("n", "<Leader>xd", "<Cmd>TroubleToggle document_diagnostics<Cr>", opts)
  u.map("n", "<Leader>xq", "<Cmd>TroubleToggle quickfix<Cr>", opts)
  u.map("n", "<Leader>xl", "<Cmd>TroubleToggle loclist<Cr>", opts)
  u.map("n", "gR", "<Cmd>TroubleToggle lsp_references<Cr>", opts)
end

return M
