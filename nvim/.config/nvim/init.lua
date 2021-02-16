local exec = vim.api.nvim_exec -- to execute vim commands
local fn = vim.fn -- to execute vim functions
local u = require('utils')

vim.g.mapleader = ' ' -- Set leader to space.
vim.o.termguicolors = true -- Enable termguicolor support.

-- Install packer.nvim, if it is not yet installed {{{1
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  exec('!git clone https://github.com/wbthomason/packer.nvim' .. ' ' ..
           install_path, false)
end
-- Plugin specification {{{1
-- Only required if you have packer in your `opt` pack
exec([[packadd packer.nvim]], false)
exec([[
  augroup Packer
    autocmd BufWritePost init.lua PackerCompile
  augroup end]], false)

local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true }

  -- Colors
  use {
    'delafthi/onedarkbuddy',
    config = function() require('colorbuddy').colorscheme('onedarkbuddy') end,
    requires = {'tjdevries/colorbuddy.vim'},
  }
  -- Comment
  use {
    'b3nj5m1n/kommentary',
    setup = require('config.kommentary').setup(),
    config = require('config.kommentary').config(),
  }
  -- Completion
  use {
    'nvim-lua/completion-nvim',
    setup = require('config.completion-nvim').setup(),
    config = require('config.completion-nvim').config(),
    requires = {
      {'nvim-treesitter/completion-treesitter', opt = true},
      {
        'norcalli/snippets.nvim',
        config = require('snippets').use_suggested_mappings()
      },
    }
  }
  -- File manager
  use {
    'kyazdani42/nvim-tree.lua',
    setup = require('config.nvim-tree').setup(),
    requires = {'kyazdani42/nvim-web-devicons'},
  }
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    config = require('config.telescope').config(),
    setup = require('config.telescope').setup(),
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
  }
  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    setup = require('config.gitsigns').setup(),
    requires = {'nvim-lua/plenary.nvim'},
  }
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    setup = require('config.nvim-lspconfig').setup(),
    requires = {{'nvim-lua/lsp-status.nvim', opt = true}, {'nvim-lua/lsp_extensions.nvim', opt = true}},
  }
  -- Note taking
  use {
    'vimwiki/vimwiki',
    setup = require('config.vimwiki').setup(),
  }
  use {
    'oberblastmeister/neuron.nvim',
    config = require('config.neuron').config(),
    setup = require('config.neuron').setup(),
    requires = {{'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope.nvim'}},
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app & yarn install',
    setup = require('config.markdown-preview').setup(),
    config = require('config.markdown-preview').config(),
    cmd = 'MarkdownPreview',
    ft = {'markdown', 'vimwiki'},
  }
  -- Start screen
  use {'mhinz/vim-startify'}
  -- Statusline
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    setup = require('config.galaxyline').setup(),
    requires = {'kyazdani42/nvim-web-devicons', opt=true},
  }
  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    setup = require('config.nvim-treesitter').setup(),
    run = ':TSUpdate',
  }
  use {
    'norcalli/nvim-colorizer.lua',
    setup = require('colorizer').setup(),
  }
  -- Text editing
  use {'godlygeek/tabular'}
  use {
    'delafthi/surround.nvim',
    setup = require('surround').setup{},
  }
end)

-- Backup {{{1
u.opt.backup = false -- Disable backups.
u.opt.confirm = true -- Prompt to save before destructive actions.
u.opt.swapfile = false -- Disable swapfiles.
u.opt.undofile = true -- Save undo history.
if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, 'p') end -- Create undo directory.
u.opt.writebackup = false -- Disable backups, when a file is written.

-- Buffers {{{1
u.opt.autoread = true -- Enable automatic reload of unchanged files.
exec([[
  augroup autoreload
    autocmd CursorHold * checktime
  augroup end]], false) -- Auto reload file, when changes where made somewhere else (for autoreload)
u.opt.hidden = true -- Enable modified buffers in the background.
u.opt.modeline = true -- Don't parse modelines (google 'vim modeline vulnerability').
-- Automatically deletes all trailing whitespace and newlines at end of file on
-- save.
exec([[
function! TrimTrailingLines()
  let lastLine = line('$')
  let lastNonblankLine = prevnonblank(lastLine)
  if lastLine > 0 && lastNonblankLine != lastLine
    silent! execute lastNonblankLine + 1 . ',$delete _'
  endif
endfunction
augroup remove
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritepre * call TrimTrailingLines()
augroup END
]], false)

-- Colorscheme {{{1
vim.g.rehash256 = 1 -- Better color support.

-- Diff {{{1
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
u.opt.diffopt = u.add({
    'context:4',
    'iwhite',
    'vertical',
    'hiddenoff',
    'foldcolumn:0',
    'indent-heuristic',
    'algorithm:histogram'
    }, vim.o.diffopt)

-- Display {{{1
u.opt.colorcolumn = '80' -- Set colorcolumn to 80
u.opt.cursorline = true -- Enable the cursorline.
u.opt.display = u.add('lastline', vim.o.display) -- On wrap display the last line even if it does not fit
u.opt.errorbells = false -- Disable annoying errors
u.opt.lazyredraw = true -- Disables redraw when executing macros and other commands.
u.opt.linebreak = true -- Prevent wrapping between words.
u.opt.list = true -- Enable listchars.
 -- Set listchar characters.
u.opt.listchars = u.add {
  'eol:↲',
  'tab:»·',
  'space: ',
  'trail:',
  'extends:…',
  'precedes:…',
  'conceal:┊',
  'nbsp:☠'
}
u.opt.number = true -- Print line numbers.
u.opt.relativenumber = true -- Set line numbers to be relative to the cursor position.
u.opt.scrolloff = 8 -- Keep 8 lines above or below the cursorline
u.opt.showbreak = '>>> ' -- Show wrapped lines with a prepended string.
u.opt.showcmd = true -- Show command in the command line.
u.opt.showmode = false -- Don't show mode in the command line.
u.opt.signcolumn = 'yes' -- Enable sign columns left of the line numbers.
u.opt.synmaxcol = 1024 -- Don't syntax highlight long lines.
u.opt.textwidth = 80 -- Max text length.
exec([[
  augroup highlight_on_yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end]], false) -- Enable highlight on yank.
vim.g.vimsyn_embed = 'lPr' -- Allow embedded syntax highlighting for lua, python, ruby.
u.opt.wrap = true -- Enable line wrapping.
u.opt.virtualedit = 'block' -- Allow cursor to move past end of line.
u.opt.visualbell = false -- Disable annoying beeps

-- Folds {{{1
u.opt.foldlevelstart = 10 -- Set level of opened folds, when starting vim.
u.opt.foldmethod = 'marker' -- The kind of folding for the current window.
u.opt.foldopen = u.add(vim.o.foldopen, 'search') -- Open folds, when something is found inside the fold.
u.opt.foldtext = 'folds#render()' -- Function called to display fold line.

-- Indentation {{{1
u.opt.autoindent = true -- Allow filetype plugins and syntax highlighting
u.opt.expandtab = true -- Use spaces instead of tabs
u.opt.joinspaces = false -- No double spaces with join after a dot
u.opt.shiftround = true -- Round indent
u.opt.shiftwidth = 2 -- Size of an indent
u.opt.smartindent = true -- Insert indents automatically
u.opt.smarttab = true -- Automatically tab to the next softtabstop
u.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
u.opt.tabstop = 2 -- Number of spaces tabs count for

-- Key mappings {{{1
opts = {noremap = true, silent = true}
u.map('i', 'ii', '<Esc>', opts) -- Remap ii as Escape.
-- Remap jk keys to navigate through visual lines.
u.map('n', 'j', 'gj', opts)
u.map('v', 'j', 'gj', opts)
u.map('n', 'k', 'gk', opts)
u.map('v', 'k', 'gk', opts)
-- Open terminal inside nvim with <Leader>tt.
u.map('n', '<Leader>tt', ':new term://fish<Cr>', opts)
-- Map window navigation to CTRL + hjkl.
u.map('n', '<C-h>', '<C-\\><C-n><C-w>h', opts)
u.map('i', '<C-h>', '<C-\\><C-n><C-w>h', opts)
u.map('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
u.map('n', '<C-j>', '<C-\\><C-n><C-w>j', opts)
u.map('i', '<C-j>', '<C-\\><C-n><C-w>j', opts)
u.map('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
u.map('n', '<C-k>', '<C-\\><C-n><C-w>k', opts)
u.map('i', '<C-k>', '<C-\\><C-n><C-w>k', opts)
u.map('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
u.map('n', '<C-l>', '<C-\\><C-n><C-w>l', opts)
u.map('i', '<C-l>', '<C-\\><C-n><C-w>l', opts)
u.map('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)
-- Better resizing of windows with CTRL + arrows
u.map('n', '<C-Left>', '<C-\\><C-n> :vertical resize +2<Cr>', opts)
u.map('i', '<C-Left>', '<C-\\><C-n> :vertical resize +2<Cr>', opts)
u.map('t', '<C-Left>', '<C-\\><C-n> :vertical resize +2<Cr>', opts)
u.map('n', '<C-Up>', '<C-\\><C-n> : resize +2<Cr>', opts)
u.map('i', '<C-Up>', '<C-\\><C-n> : resize +2<Cr>', opts)
u.map('t', '<C-Up>', '<C-\\><C-n> : resize +2<Cr>', opts)
u.map('n', '<C-Down>', '<C-\\><C-n> : resize -2<Cr>', opts)
u.map('i', '<C-Down>', '<C-\\><C-n> : resize -2<Cr>', opts)
u.map('t', '<C-Down>', '<C-\\><C-n> : resize -2<Cr>', opts)
u.map('n', '<C-Right>', '<C-\\><C-n> :vertical resize -2<Cr>', opts)
u.map('i', '<C-Right>', '<C-\\><C-n> :vertical resize -2<Cr>', opts)
u.map('t', '<C-Right>', '<C-\\><C-n> :vertical resize -2<Cr>', opts)
-- Change splits layout from vertical to horizontal or vice versa.
u.map('n', '<Leader>lv', '<C-w>t<C-w>H', opts)
u.map('n', '<Leader>lh', '<C-w>t<C-w>K', opts)
-- Better indenting in the visual mode.
u.map('v', '<', '<gv', opts)
u.map('v', '>', '>gv', opts)
-- Show buffers and select one to kill.
u.map('n', '<Leader>bk', ':ls<Cr>:bd<Space>', opts)
-- Toggle spell checking.
u.map('n', '<Leader>o', ':setlocal spell!<Cr>', opts)
-- Use <Tab> and <S-Tab> to navigate through completion suggestion.
u.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, silent = true})
u.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true, silent = true})
-- Try to save file with sudo on files that require root permission
exec([[ca w!! w !sudo tee >/dev/null "%"]], false)

-- Mouse {{{1
u.opt.mouse = 'nvicr' -- Enables different support modes for the mouse

-- Netrw {{{1
vim.g.netrw_banner = 0 -- Disable banner on top of the window.

-- Search {{{1
u.opt.hlsearch = true -- Enable search highlighting.
u.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
u.opt.ignorecase = true -- Ignore case when searching.
u.opt.smartcase = true -- Don't ignore case with capitals.
u.opt.wrapscan = true -- Searches wraps at the end of the file.
-- Use faster grep alternatives if possible
if fn.executable('rg') > 0 then
    u.opt.grepprg =
        [[rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*]]
    u.opt.grepformat = u.add('%f:%l:%c:%m', vim.o.grepformat)
end

-- Spell checking {{{1
u.opt.spelllang = 'en_us,de_ch' -- Set spell check languages.

-- Splits {{{1
-- Fill characters for the statusline and vertical separators
u.opt.fillchars = u.add {
    'stl: ',
    'stlnc:-',
    'vert:│',
    'fold: ',
    'foldopen:▾',
    'foldclose:▸',
    'foldsep:│',
    'diff:',
    'msgsep:‾',
    'eob:~',
}
u.opt.splitbelow = true -- Put new windows below the current.
u.opt.splitright = true -- Put new windows right of the current.

-- Statusline {{{1
u.opt.laststatus = 2 -- Always show the statusline

-- Timings {{{1
u.opt.timeout = true -- Determines with 'timeoutlen' how long nvim waits for further commands after a command is received.
u.opt.timeoutlen = 500 -- Wait 500 milliseconds for further input.
u.opt.ttimeoutlen = 10 -- Wait 10 milliseconds in mappings with CTRL.

-- Title {{{1
u.opt.title = true -- Set window title by default.
u.opt.titlelen = 70 -- Set maximum title length.
u.opt.titleold = '%{fnamemodify(getcwd(), ":t")}' -- Set title, while exiting the vim.
u.opt.titlestring = '%t' -- Set title string.

-- Utils {{{1
u.opt.backspace = 'indent,eol,start' -- Change backspace to behave more intuitively.
u.opt.clipboard = 'unnamedplus' -- Enable copy paste into and out of nvim.
u.opt.completeopt = u.add {'menu', 'noinsert', 'noselect', 'longest'} -- Set completionopt to have a better completion experience.
u.opt.inccommand = 'nosplit' -- Show the effect of a command incrementally, as you type.
u.opt.path = u.add('**', vim.o.path) -- Searches current directory recursively

-- Wildmenu {{{1
u.opt.wildmenu = true -- Enable commandline autocompletion menu.
u.opt.wildmode = 'full' -- Select completion mode.
u.opt.wildignorecase = true -- Ignores case when completing.
u.opt.wildoptions = 'pum' -- Display the completion matches using the popupmenu.

-- }}}1
