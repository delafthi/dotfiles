""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved, required
filetype off " required
let g:polyglot_disabled = ['markdown.plugin'] " Needs to be defined before loading polyglot

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins managed by Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" File management
    Plug 'vifm/vifm.vim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
" Productivity
    Plug 'junegunn/goyo.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-surround'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'preservim/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-treesitter/completion-treesitter'
    Plug 'tjdevries/cyclist.vim',
" Syntax Highlighting and language support
    Plug 'ap/vim-css-color'
    Plug 'sheerun/vim-polyglot'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Themes
    Plug 'delafthi/onehalf', { 'rtp': 'vim' }

call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
"                     :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"                     auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load lua lsp config
lua require('lsp_config')
" Load lua treesitter config
lua require('treesitter_config')
" Load lua telescope config
lua require('telescope_config')
" Set window title by default.
set title
" Don't display the intro message on starting Vim.
set shortmess+=I
" Searches current directory recursiveliy
set path+=**
" Needed to keep multiple buffers open
set hidden
" No auto backups
set nobackup
" No swap files
set noswapfile
" If terminal supports truecolor
if exists('+termguicolors')
    let &g:t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &g:t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " Set 24bit color support
    set termguicolors
else
    " Else set 256 color mode
    set t_Co=256
endif
" Display line numbers
set number relativenumber
" Copy/paste between vim and other programs
set clipboard=unnamedplus
" Enable better theme colors
let g:rehash256 = 1
" Reload unchanged files automatically.
set autoread
" Auto reload if file was changed somewhere else (for autoread)
au CursorHold * checktime
" Disable annoying error and beeps
set noerrorbells
set visualbell
" Don't parse modelines (google "vim modeline vulnerability").
set nomodeline
" Search upwards for tags file instead only locally
if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif
" Fix issues with fish shell
" https://github.com/tpope/vim-sensible/issues/50
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
    set shell=/usr/bin/env\ bash
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete

" Display all matches when tab complete
set wildmenu
" Set autocomplete mode
set wildmode=longest,full
" Remove popup menu for autocompletion
set wildoptions-=pum
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid shoving message extra message when using completion
set shortmess+=c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search

" Incremental search
set incsearch
" Enable search highlighting.
set hlsearch
" Ignore case when searching.
set ignorecase
" Don't ignore case when search has capital letter
" (although also don't ignore case by default).
set smartcase
" Use dash as word separator.
set iskeyword+=-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related

" Highligt cursorline
set cursorline
" Keep 8 lines above or below t
set scrolloff=8
" Set textwidth to 80 columns
set textwidth=80
" Prevents word wrapping in between words
set wrap linebreak
" String to put at the start of the line if the line has been wrapped
let &g:showbreak='>>> '
" On 'wrap' display the last line even if it does not fit
set display +=lastline
" Set options of automatic formating
set formatoptions=tcqj
" Set spell check languages
set spelllang=en_us,de_ch
" Enable syntax highlighting
syntax on
" Use spaces instead of tabs.
set expandtab
" Be smart using tabs ;)
set smarttab
" One tab == four spaces.
set shiftwidth=4
" One tab == four spaces.
set tabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme

"Enable corolscheme onehalfdark
colorscheme onehalfdark
" Set column 80 to be highlighted
set colorcolumn=80
" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline

" Always show the statusline
set laststatus=2
" Show all modes in the statusline
set noshowmode

" Custom functions called in the statusline
let g:translateMode={
            \ 'n' : 'NORMAL',
            \ 'i' : 'INSERT',
            \ 'c' : 'COMMAND',
            \ 'v' : 'VISUAL',
            \ 'V' : 'V-LINE',
            \ '^V' : 'V-BLOCK',
            \ 'r' : 'REPLACE',
            \ 'R' : 'R-CONTINOUS',
            \}

function! StatuslineLsp()
    let l:sl = ''
    let l:numError = luaeval('vim.lsp.diagnostic.get_count(0, [[Error]])')
    let l:numWarning = luaeval('vim.lsp.diagnostic.get_count(0, [[Warning]])')
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        if and(l:numError == 0, l:numWarning == 0)
            let l:sl = '✓'
        else
            if l:numError > 0
                let l:sl.= ' :'.l:numError
            endif
            if l:numWarning > 0
                let l:sl.= ' :'.l:numWarning
            endif
        endif
    endif
    return l:sl
endfunction

function! StatuslineModified()
    if getbufinfo()[0].changed
        let l:sl = ' [+] '
    else
        let l:sl = ''
    endif
    return l:sl
endfunction

function! StatuslineReadOnly()
    if &readonly || !&modifiable
        let s:sl = ' [RO] '
    else
        let s:sl = ''
    endif
    return s:sl
endfunction

let s:slSeparator = '%#StatusLineNC#|'
let s:slLinemode = '%#StatusLineMode# %{toupper(g:translateMode[mode()])} '.s:slSeparator
let s:slFilename = '%#StatusLineFileName# %-t '
let s:slModified = '%#StatusLineReadOnly#%{StatuslineReadOnly()}'
let s:slModified = '%#StatusLineModified#%{StatuslineModified()}'.s:slSeparator
let s:slLsp = '%#StatusLineLsp# %{StatuslineLsp()}'
let s:slEncoding = s:slSeparator.'%#StatusLineEncoding# %-{&fileencoding?&fileencoding:&encoding} '
let s:slFiletype = s:slSeparator.'%#StatusLineFileType# %-Y '
let s:slPercentage = s:slSeparator.'%#StatusLinePercentage# %p%% '
let s:slLinenumber = s:slSeparator.'%#StatusLineLineNumber# %l/%L '
let s:slLeft = s:slLinemode.s:slFilename.s:slModified.s:slLsp
let s:slRight = s:slEncoding.s:slFiletype.s:slPercentage.s:slLinenumber
let &g:statusline = s:slLeft.'%*%='.s:slRight

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits and Tabbed Files

" The new window is is displayed on the right or below
set splitbelow splitright
" Fill the vertical separator with |
set fillchars+=vert:\|
" Fill the horizontal separator with -
set fillchars+=stlnc:-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings

" Remap ESC to ii
inoremap ii <Esc>
" Remap Leader key to SPACE
let g:mapleader = "\<Space>"
" Remap hjkl keys to navigate also the wrapped lines
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> k gk
" Open terminal inside Vim
nnoremap <silent> <Leader>tt :new term://fish<cr>
" Remap splits navigation to just CTRL + hjkl
tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l
inoremap <silent> <C-h> <C-\><C-n><C-w>h
inoremap <silent> <C-j> <C-\><C-n><C-w>j
inoremap <silent> <C-k> <C-\><C-n><C-w>k
inoremap <silent> <C-l> <C-\><C-n><C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Make adjusting split sizes a bit more friendly
tnoremap <silent> <C-Left> <C-\><C-n> :vertical resize +2<cr>
tnoremap <silent> <C-Up> <C-\><C-n> :resize +2<cr>
tnoremap <silent> <C-Down> <C-\><C-n> :resize -2<cr>
tnoremap <silent> <C-Right> <C-\><C-n> :vertical resize -2<cr>
inoremap <silent> <C-Left> :vertical resize +2<cr>
inoremap <silent> <C-Up> :resize +2<cr>
inoremap <silent> <C-Down> :resize -2<cr>
inoremap <silent> <C-Right> :vertical resize -2<cr>
nnoremap <silent> <C-Left> :vertical resize +2<cr>
nnoremap <silent> <C-Up> :resize +2<cr>
nnoremap <silent> <C-Down> :resize -2<cr>
nnoremap <silent> <C-Right> :vertical resize -2<cr>
" Change 2 split windows from vert to horiz or horiz to vert
nnoremap <silent> <leader>lv <C-w>t<C-w>H
nnoremap <silent> <leader>lh <C-w>t<C-w>K
" Show current buffer and change to buffer
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
" Kill specified buffer
nnoremap <silent> <leader>bk :ls<cr>:bd<Space>
" Search for files located in the same in recursive dirs
nnoremap <silent> <leader>ff <cmd>Telescope find_files<cr>
" global grep in project files
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<cr>
" Enable/Disable spell checker
noremap <silent> <leader>o :setlocal spell!<cr>
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse settings

" Sets the current mouse mode as normal, visual , insert and
set mouse=nvicr

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gui options

"remove menu bar
set guioptions-=m
"remove toolbar
set guioptions-=T
"remove right-hand scroll bar
set guioptions-=r
"remove left-hand scroll bar
set guioptions-=L

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types

" Markdown
au! BufRead,BufNewFile,BufFilePre *.markdown set filetype=mkd
au! BufRead,BufNewFile,BufFilePre *.md set filetype=mkd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other functions

" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
autocmd BufWritePre * mark m | %s/\s\+$//e | try | 'm | catch | G | endtry
autocmd BufWritepre * mark m | %s/\n\+\%$//e | try | 'm | catch | G | endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-completion

" Enable nvim-completion
autocmd BufEnter * lua require('completion').on_attach()
" Configure the completion chains
let g:completion_chain_complete_list = {
            \ 'default' : {
            \     'default' : [
            \         {'complete_items' : ['ts']},
            \         {'complete_items' : ['lsp']},
            \         {'mode' : 'file'},
            \     ],
            \     'func' : [
            \         {'complete_items' : ['lsp']},
            \     ],
            \     'string' : [
            \         {'complete_items' : ['ts']},
            \         {'complete_items' : ['lsp']},
            \         {'mode' : 'file'},
            \     ],
            \     'comment' : [],
            \ },
            \}
" Enable auto popup
let g:completion_enable_auto_popup = 1
" Disable auto hover
let g:completion_enable_auto_hover = 0
" Disable auto signature
let g:completion_enable_auto_signature = 0
" set sorting of completion items (possible values: 'length', 'alphabet', 'none'
let g:completion_sorting = 'none'
" Set matching strategy
let g:completion_matching_strategy = 'exact'
" Enable smart case matching
let g:completion_matching_smart_case = 1
" Automatically change the completion source
let g:completion_auto_change_source = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo
"
nnoremap <silent> <leader>gg :Goyo<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cyclist

" Cycle through the differenc cyclist configurations
nmap <silent> <leader>ln <plug>CyclistNext
nmap <silent> <leader>lp <plug>CyclistPrev

call cyclist#add_listchar_option_set('all', {
            \ 'eol': '↲',
            \ 'tab': '»·',
            \ 'space': '␣',
            \ 'trail': '-',
            \ 'extends': '☛',
            \ 'precedes': '☚',
            \ 'conceal': '┊',
            \ 'nbsp': '☠',
            \ })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vifm

nnoremap <silent> <leader>vv :Vifm<cr>
nnoremap <silent> <leader>vs :VsplitVifm<cr>
nnoremap <silent> <leader>sp :SplitVifm<cr>
nnoremap <silent> <leader>dv :DiffVifm<cr>
nnoremap <silent> <leader>tv :TabVifm<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimWiki

" Disable rainbow mode in vimwiki
let g:vimwiki_list = [{
            \ 'path': '~/Vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md',
            \ 'auto_tags': 1, 'auto_toc': 1,
            \ }]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_chdir = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown-Preview

" If set to 1 markdown preview is only refreshed, when the buffer is saved or
" insert mode is exited
let g:mkdp_refresh_slow = 0
" Browser to open the preview
let g:mkdp_browser = 'brave'
" Define title of the browser page
let g:mkdp_page_tittle = '${name}'
" Set keybinging to launch the markdown preview
autocmd Filetype mkd,vimwiki nmap <silent> <leader>mp <plug>MarkdownPreviewToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/**','right': '*/' },
            \ 'python': { 'left': '#','right': '' },
            \ }
