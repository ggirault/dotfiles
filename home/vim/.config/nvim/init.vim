let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    execute '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path
call plug#begin(stdpath('config') . '/plugged')
" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Colors
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'


" Edit
Plug 'sgur/vim-editorconfig'
Plug 'junegunn/rainbow_parentheses.vim'

" Lint
Plug 'w0rp/ale'

" Languages
Plug 'hashivim/vim-terraform'

" Powerline alternative
Plug 'vim-airline/vim-airline'

" NerdTree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

call plug#end()
call plug#helptags()

" auto install vim-plug and plugins:
if plug_install
    PlugInstall --sync
endif
unlet plug_install

" ================ Syntax Highlighting ======================

if has("termguicolors")
	set termguicolors
endif

try
    colorscheme gruvbox
catch
    colorscheme ggirault
endtry

" ================ General Config ===================

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.

let mapleader      = ','
let maplocalleader = ','

syntax on                       "Turn on syntax highlighting

set ruler
set number                      "Show line numbers
"set relativenumber
set nocursorcolumn
set visualbell
set laststatus=2
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set autoread                    "Reload files changed outside vim

set cursorline

" ================ Mouse ======================

set mouse=a                     "Enable mouse in all mode

" ================ Editing UI ======================

" Change cursor shape
"if &term =~ "xterm"
"  let &t_SI .= "\e[5 q"
"  let &t_SR .= "\e[3 q"
"  let &t_EI .= "\e[2 q"
"endif

" Display tabs and trailing spaces visually
set list
set listchars=tab:→\ ,trail:·,nbsp:·,precedes:«,extends:»,eol:¶

set wrap                        "Wrap lines
set linebreak                   "Wrap lines at convenient points

set sidescroll=5
set sidescrolloff=15

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype on
filetype plugin on
filetype indent on

" ================ Searching ======================

set ignorecase                  "Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set incsearch                   "Shows the match while typing
set hlsearch                    "Highlight all matches

" ================ Clipboard ======================
" Get Clipboard copy/paste
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
noremap <Leader>y "*y
"noremap <Leader>p "*p
noremap <Leader>Y "+y
"noremap <Leader>P "+p

" Temporarily highlight yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=400 }
augroup END

" ================ Swapfiles, backups, undos ======================

set swapfile
set directory^=~/.cache/nvim/backup//

set nobackup                    "Don't create annoying backup files
set backupdir^=~/.cache/nvim/backup//

set undofile
set undodir^=~/.cache/nvim/undo//

" ================ Encoding ======================

set encoding=utf-8              "Set default encoding to UTF-8

" ================ Tab/Buffer settings ======================

set hidden

" ================ Keyboard ======================

" Quit
inoremap <C-q>     <esc>:q<cr>
nnoremap <C-q>     :q<cr>
vnoremap <C-q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Open files
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>

nnoremap <C-p> :GFiles<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Tag finder
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>

" Line finder
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n>     :NERDTree<CR>
nnoremap <C-t>     :NERDTreeToggle<CR>
nnoremap <C-f>     :NERDTreeFind<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeShowHidden = 1 
let g:NERDTreeStatusline = '' " set to empty to use lightline
let g:NERDTreeHighlightFolders = 1 " Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " Highlights the folder name


let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExactMatchHighlightColor = {} 
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
let g:WebDevIconsDefaultFileSymbolColor = s:blue 


"let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
"let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
"
"let g:NERDTreeDisableFileExtensionHighlight = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
"let g:NERDTreeDisablePatternMatchHighlight = 1
"
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
"
"let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
"let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name