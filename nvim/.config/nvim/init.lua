local cmd = vim.cmd -- to execute vim commands without any output
local fn = vim.fn -- to execute vim functions

vim.g.mapleader = " " -- Set leader to space.
vim.o.termguicolors = true -- Enable termguicolor support.

-- Backup {{{1
vim.opt.backup = false -- Disable backups.
vim.opt.confirm = true -- Prompt to save before destructive actions.
vim.opt.swapfile = false -- Disable swapfiles.
vim.opt.undofile = true -- Save undo history.
if fn.isdirectory(vim.o.undodir) == 0 then
  fn.mkdir(vim.o.undodir, "p")
end -- Create undo directory.
vim.opt.writebackup = false -- Disable backups, when a file is written.

-- Buffers {{{1
vim.opt.autoread = true -- Enable automatic reload of unchanged files.
cmd([[
  augroup autoreload
    autocmd CursorHold * checktime
  augroup END
]]) -- Auto reload file, when changes where made somewhere else (for autoreload)
vim.opt.hidden = true -- Enable modified buffers in the background.
vim.opt.modeline = true -- Don't parse modelines (google 'vim modeline vulnerability').
-- Automatically deletes all trailing whitespace and newlines at end of file on
-- save.
cmd([[
  function! TrimTrailingLines()
    let lastLine = line('$')
    let lastNonblankLine = prevnonblank(lastLine)
    if lastLine > 0 && lastNonblankLine != lastLine
      silent! execute lastNonblankLine + 1 . ',$delete _'
    endif
  endfunction
  augroup remove_trailing_whitespaces_and_lines
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritepre * call TrimTrailingLines()
  augroup END
]])
-- Try to save file with sudo on files that require root permission
cmd([[ca w!! w !sudo tee >/dev/null "%"]])

-- Diff {{{1
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
vim.opt.diffopt:prepend({
  "context:4",
  "iwhite",
  "vertical",
  "hiddenoff",
  "foldcolumn:0",
  "indent-heuristic",
  "algorithm:histogram",
})

-- Display {{{1
vim.opt.colorcolumn = "80" -- Set colorcolumn to 80
vim.opt.cursorline = true -- Enable the cursorline.
vim.opt.display:prepend("lastline") -- On wrap display the last line even if it does not fit
vim.opt.errorbells = false -- Disable annoying errors
vim.opt.lazyredraw = true -- Disables redraw when executing macros and other commands.
vim.opt.linebreak = true -- Prevent wrapping between words.
vim.opt.list = true -- Enable listchars.
-- Set listchar characters.
vim.opt.listchars = {
  eol = "↲",
  tab = "»·",
  space = " ",
  trail = "",
  extends = "…",
  precedes = "…",
  conceal = "┊",
  nbsp = "☠",
}
vim.opt.number = true -- Print line numbers.
vim.opt.relativenumber = true -- Set line numbers to be relative to the cursor position.
vim.opt.scrolloff = 8 -- Keep 8 lines above or below the cursorline
vim.opt.showbreak = ">>> " -- Show wrapped lines with a prepended string.
vim.opt.showcmd = true -- Show command in the command line.
vim.opt.showmode = false -- Don't show mode in the command line.
vim.opt.signcolumn = "yes" -- Enable sign columns left of the line numbers.
vim.opt.synmaxcol = 1024 -- Don't syntax highlight long lines.
vim.opt.textwidth = 80 -- Max text length.
cmd([[
  augroup highlight_on_yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]]) -- Enable highlight on yank.
vim.g.vimsyn_embed = "lPr" -- Allow embedded syntax highlighting for lua, python, ruby.
vim.opt.wrap = true -- Enable line wrapping.
vim.opt.visualbell = false -- Disable annoying beeps
vim.opt.shortmess = "c" -- Avoid showing extra messages when using completion

-- Editing
vim.opt.virtualedit = "block" -- Allow cursor to move past end of line.
vim.opt.autoindent = true -- Allow filetype plugins and syntax highlighting
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.smarttab = true -- Automatically tab to the next softtabstop
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
vim.opt.tabstop = 2 -- Number of spaces tabs count for

cmd([[
  augroup formatOptions
    autocmd Filetype * set fo-=r fo-=o
  augroup END
]]) -- Disables automatic insertion of comment leaders

-- Filetypes {{{1
cmd([[
  augroup additionalFiletypes
    autocmd!
    autocmd BufNewFile,BufRead *.cl set filetype=cpp
    autocmd BufNewFile,BufRead *.bb set filetype=sh
    autocmd BufNewFile,BufRead *.bbappend set filetype=sh
  augroup END
]]) -- Set various filetypes
vim.g.tex_flavor = "latex" -- Set latex as the default tex flavor

-- Folds {{{1
vim.opt.foldlevelstart = 10 -- Set level of opened folds, when starting vim.
vim.opt.foldmethod = "marker" -- The kind of folding for the current window.
vim.opt.foldopen:append("search") -- Open folds, when something is found inside the fold.
vim.opt.foldtext = [[luaeval("require('util').foldtext()")]] -- Function called to display fold line.

-- Mouse {{{1
vim.opt.mouse = "nvicr" -- Enables different support modes for the mouse

-- Netrw {{{1
vim.g.netrw_banner = 0 -- Disable the banner on top of the window.

-- Search {{{1
vim.opt.hlsearch = true -- Enable search highlighting.
vim.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
vim.opt.ignorecase = true -- Ignore case when searching.
vim.opt.smartcase = true -- Don't ignore case with capitals.
vim.opt.wrapscan = true -- Searches wraps at the end of the file.
-- Use faster grep alternatives if possible
if fn.executable("rg") > 0 then
  vim.opt.grepprg =
    [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
  vim.opt.grepformat:prepend("%f:%l:%c:%m")
end

-- Spell checking {{{1
-- Set spell check languages.
vim.opt.spelllang = { "en_us", "de_ch" }

-- Splits {{{1
-- Fill characters for the statusline and vertical separators
vim.opt.fillchars = {
  stl = " ",
  stlnc = " ",
  vert = "│",
  fold = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = "│",
  diff = "",
  msgsep = "‾",
  eob = "~",
}
vim.opt.splitbelow = true -- Put new windows below the current.
vim.opt.splitright = true -- Put new windows right of the current.

-- Statusline {{{1
vim.opt.laststatus = 2 -- Always show the statusline

-- Terminal {{{1
cmd([[
  augroup terminal
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
  augroup END
]]) -- Automatically go to insert mode, when changing to the terminal window

-- Timings {{{1
vim.opt.timeout = true -- Determines with 'timeoutlen' how long nvim waits for further commands after a command is received.
vim.opt.timeoutlen = 500 -- Wait 500 milliseconds for further input.
vim.opt.ttimeoutlen = 10 -- Wait 10 milliseconds in mappings with CTRL.

-- Title {{{1
vim.opt.title = true -- Set window title by default.
vim.opt.titlelen = 70 -- Set maximum title length.
vim.opt.titleold = "%{fnamemodify(getcwd(), ':t')}" -- Set title while exiting vim
vim.opt.titlestring = "%t" -- Set title string.

-- Utils {{{1
-- Change backspace to behave more intuitively.
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamedplus" -- Enable copy paste into and out of nvim.
-- Set completionopt to have a better completion experience.
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.inccommand = "nosplit" -- Show the effect of a command incrementally, as you type.
vim.opt.path:prepend("**") -- Searches current directory recursively

-- Wildmenu {{{1
vim.opt.wildmenu = true -- Enable commandline autocompletion menu.
vim.opt.wildmode = "full" -- Select completion mode.
vim.opt.wildignorecase = true -- Ignores case when completing.
vim.opt.wildoptions = "pum" -- Display the completion matches using the popupmenu.

-- Load Plugins at the end {{{1
vim.defer_fn(function()
  require("plugins")
end, 0)

-- }}}1
