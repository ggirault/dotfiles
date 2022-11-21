HOME = os.getenv("HOME")
CACHE = os.getenv("XDG_CACHE_HOME")

vim.g.loaded_perl_provider = 0  -- Disable perl provider
vim.g.loaded_ruby_provider = 0  -- Disable ruby provider
vim.g.loaded_node_provider = 0  -- Disable node provider

-- Mapping
local set = vim.opt

-- basic settings
set.encoding = 'utf-8'
set.backspace = {'indent','eol','start'} -- backspace work on every char in insert mode
set.completeopt = {'menu', 'menuone', 'noselect'}
set.wildmenu = true -- on TAB, complete options for system command
set.history = 1000
set.completeopt = 'menu,menuone,preview' -- show possible completions
set.dictionary = '/usr/share/dict/words' -- word completion with i_CTRL-X_CTRL-K

set.clipboard = {'unnamed','unnamedplus'}

-- Mapping waiting time
set.timeout = false
set.ttimeout = true
set.ttimeoutlen = 100

-- Display
set.showmatch = true -- show matching brackets
set.scrolloff = 3 -- always show 3 rows from edge of the screen
set.sidescroll = 5 -- minimal number of columns to scroll horizontally
set.sidescrolloff = 15 -- minimal number of columns to keep to the left and o the right
set.synmaxcol = 300 -- stop syntax highligh after x lines for performance
set.laststatus = 2 -- always show status line
set.visualbell = true

set.list = true -- display white characters
set.listchars = {tab='→ ',trail='·',nbsp='·',precedes='«',extends='»',eol='↲'}
set.foldenable = false
set.foldlevel = 4 -- limit folding to 4 levels
set.foldmethod = 'syntax' -- use language syntax to generate folds
set.wrap = true -- wrap lines even if very long
set.eol = true -- show if there's no eol char
set.startofline = false -- do not move the cursor to the first non-blank of the line
set.showbreak = '↪︎ ' -- character to show when line id broken
set.breakindent = true -- preserve the indentation of a virtual line
set.breakindentopt = 'sbr' -- display the 'showbreak' value before applying the additional indent

-- Sidebar
set.number = true -- line number on the left combined with ...
set.relativenumber = true -- to show line number + relative number
set.numberwidth = 3 -- always reserve 3 spaces for line number
set.modelines = 0
set.showcmd = true -- display command in bottom bar
set.showmode = true -- display current mode down the bottom

-- Search
set.incsearch = true -- starts searching as soon as typing, without enter needed
set.ignorecase = true -- ignore letter case when searching
set.smartcase = true -- case insentive unless capitals used in search
set.hlsearch = true -- hightlight all matches
set.matchtime = 2 -- delay before showing matching parent
set.mps = vim.o.mps .. ",<:>"

-- White characters
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.tabstop = 2 -- 1 tab = 2 spaces
set.shiftwidth = 2 -- indentation rule
set.softtabstop = 2
set.expandtab = true -- expand tab to spaces
set.formatoptions = 'rqnj1' -- r - auto-insert comment leader on <Enter>; q - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Search
set.ignorecase = true -- search case insensitive
set.smartcase = true -- ... but not when search pattern contains upper case characters
set.incsearch = true -- show match while typing
set.hlsearch = true-- highligh all matches
set.wildignore = {'*/cache/*', '*/tmp/*', '*/.venv*'}

-- Backup files
set.backup = true -- use backup files
set.writebackup = true -- backup before overwriting a file
set.swapfile = true -- use swap file
set.undofile = true -- save history to an undo file
set.undodir = CACHE .. '/nvim/undo//'     -- undo files
set.backupdir = CACHE .. '/nvim/backup//' -- backups
set.directory = CACHE .. '/nvim/swap//'   -- swap files

