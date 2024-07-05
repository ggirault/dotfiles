local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local vim_files = {
  'autocommands.vim'
}

-- ChangeBackground changes the background mode based on macOS's `Appearance
-- setting. 
local function change_background()
  local m = vim.fn.system("defaults read -g AppleInterfaceStyle")
  m = m:gsub("%s+", "") -- trim whitespace
  if m == "Dark" then
    vim.o.background = "dark" 
  else
    vim.o.background = "light" 
  end
end

-- source vim files
--for _, name in ipairs(vim_files) do
--  local path = string.format("%s/lua/%s", vim.fn.stdpath("config"), name)
--  local source_cmd = "source " .. path
--  vim.cmd(source_cmd)
--end

vim.api.nvim_create_user_command(
  'ReloadConfig',
  'source $MYVIMRC | PackerCompile',
  {}
)

----------------
--- plugins ---
----------------
require("lazy").setup({
  -- colorscheme
  { 
    "ellisonleao/gruvbox.nvim", 
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function ()
      change_background()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {string = true, operators = true, comments = true},
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = true,
        transparent_mode = false,
        --contrast = "hard"
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- statusline
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require("lualine").setup({
        --options = { theme = 'gruvbox' },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          }
        }
      })
    end,
  },

  -- Show thin vertical lines on each indentation level.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({
        scope = { highlight = highlight },
      })
    end
  },
  
  -- Highlight, edit, and navigate code
  { 
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'go',
          'gomod',
          'lua',
          'python',
          'rust',
          'vimdoc',
          'vim',
          'bash',
          'markdown',
          'markdown_inline',
          'mermaid',
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<space>", -- maps in normal mode to init the node/scope selection with space
            node_incremental = "<space>", -- increment to the upper named parent
            node_decremental = "<bs>", -- decrement to the previous node
            scope_incremental = "<tab>", -- increment to the upper scope (as defined in locals.scm)
          },
        },
        autopairs = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        highlight = {
          enable = true,

          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ["iB"] = "@block.inner",
              ["aB"] = "@block.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']]'] = '@function.outer',
            },
            goto_next_end = {
              [']['] = '@function.outer',
            },
            goto_previous_start = {
              ['[['] = '@function.outer',
            },
            goto_previous_end = {
              ['[]'] = '@function.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sn'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>sp'] = '@parameter.inner',
            },
          },
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function() 
      require("nvim-autopairs").setup {
        check_ts = true,
      }
    end
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function() 
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },

  -- lsp-config
  {
    "neovim/nvim-lspconfig", 
    config = function ()
      util = require "lspconfig/util"

      local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      require('lspconfig').tsserver.setup({})
    end,
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      luasnip.config.setup {}

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      require('cmp').setup({
        snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              nvim_lsp_signature_help = "[Sig]",
              nvim_lua = "[Lua]",
              path = '[Path]',
            },
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
          ['<Down>'] = cmp.mapping.select_next_item(select_opts),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          ['<Tab>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          --['<Tab>'] = cmp.mapping(function(fallback)
          --  if cmp.visible() then
          --    cmp.select_next_item()
          --  elseif luasnip.expand_or_locally_jumpable() then 
          --    luasnip.expand_or_jump()
          --  elseif has_words_before() then
          --    cmp.complete()
          --  else
          --    fallback()
          --  end
          --end, { 'i', 's' }),
          --['<S-Tab>'] = cmp.mapping(function(fallback)
          --  if cmp.visible() then
          --    cmp.select_prev_item()
          --  elseif luasnip.jumpable(-1) then
          --    luasnip.jump(-1)
          --  else
          --    fallback()
          --  end
          --end, { 'i', 's' }),
        },
        -- don't auto select item
        preselect = cmp.PreselectMode.None,
        window = {
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = {
            name = "custom",
            selection_order = "near_cursor",
          },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Insert,
        },
        sources = {
          { name = 'nvim_lsp', keyword_length = 2, priority = 10 },  -- from language server
          { name = 'nvim_lsp_signature_help', priority = 20 },       -- display function signature with current parameter emphasized
          { name = 'path' },                                         -- file paths
          { name = 'nvim_lua', keyword_length = 2},                  -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer', keyword_length = 4 },                   -- source current buffer
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = {
          keyword_length = 3,
          completeopt = "menu,menuone,select",
        },
      })
    end,
  },

  -- save my last cursor position
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
      })
    end,
  },

  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
      "zhaozg/vim-diagram",
      "aklt/plantuml-syntax",
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  },

  -- commenting out lines
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        opleader = {
          ---Block-comment keymap
          block = '<Nop>',
        },
      }) 
    end
  },

  -- Highlight URLs inside vim
  {
    'itchyny/vim-highlighturl',
    event = 'VimEnter',
  },

  -- FZF
  {
    'junegunn/fzf',
    run = ':call fzf#install()' 
  },
  {
    'junegunn/fzf.vim'
  },

  -- Show git change signs in vim sign column
  {
    'lewis6991/gitsigns.nvim'
  },

  -- Bash
  {
    'bash-lsp/bash-language-server',
    config = function() require('lspconfig').bashls.setup{} end
  },

  -- Rust
  {
    'simrat39/rust-tools.nvim',
    config = function()
      local opts = {
        -- rust-tools options
        tools = {
          autoSetHints = true,
          inlay_hints = {
            only_current_line = false,      -- only show inlay hints for the current line
            show_parameter_hints = true,    -- whether to show parameter hints with the inlay hints or not
            parameter_hints_prefix = "<- ", -- prefix for parameter hints
            other_hints_prefix = "=> ",     -- prefix for all the other hints (type, chaining)
            highlight = "Comment",          -- the color of the hints
          },
        },
        hover_actions = {
          -- the border that is used for the hover window
          -- see vim.api.nvim_open_win()
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
          auto_focus = false,     -- whether the hover action window gets automatically focused
        },
        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        -- https://rust-analyzer.github.io/manual.html#features
        server = {
          standalone = true,  -- standalone file support
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", require'rust-tools'.hover_actions.hover_actions, { buffer = bufnr })         -- Hover actions
            vim.keymap.set("n", "<Leader>a", require'rust-tools'.code_action_group.code_action_group, { buffer = bufnr }) -- Code action groups
          end,
          settings = {
            ["rust-analyzer"] = {
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate"
              },
              cargo = {
                allFeatures = true
              },
              checkOnSave = {
                -- default: `cargo check`
                command = "cargo check"
              },
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = true,
                useParameterNames = true
              },
            },
          }
        },
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        },
      }

      require('rust-tools').setup(opts)
    end
  },
})


----------------
--- key maps ---
----------------

vim.g.mapleader = ','
vim.g.malocalpleader = '\\'

local opts = { noremap = true, silent = true }
 
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   '': Yes, an empty string. Is the equivalent of n + v + o.
 
-- Clipboard --
vim.keymap.set("", "<Leader>y", "*y", opts)
vim.keymap.set("", "<Leader>Y", "+y", opts)
vim.keymap.set("", "<Leader>p", "*p", opts)
vim.keymap.set("", "<Leader>P", "+p", opts)
 
-- Quit --
vim.keymap.set("n", "<C-q>", "<Esc>:q<CR>", opts)
vim.keymap.set("i", "<C-q>", ":q<CR>", opts)
 
-- Save --
vim.keymap.set("n", "<C-s>", ":update<CR>", opts)
vim.keymap.set("i", "<C-s>", "<C-O>:update<CR>", opts)


-- FZF
vim.keymap.set('n', '<leader>f', ':GFiles<CR>', { silent = true, desc = 'Show all git files' }) -- git files
vim.keymap.set('n', '<leader>F', ':Files<CR>', { silent = true, desc = 'Show files in current path' }) -- files
vim.keymap.set('n', '<leader>H', ':HomeFiles<CR>', { silent = true, desc = 'Show files from HOME directory' }) -- files
vim.keymap.set('n', '<leader>?', ':GFiles?<CR>', { silent = true, desc = 'git status' }) -- git status
vim.keymap.set('n', '<leader>b', ':Buffers<CR>', { silent = true, desc = 'Show open buffers' }) -- open buffers
vim.keymap.set('n', '<leader>l', ':BLines<CR>', { silent = true, desc = 'Show lines in the current buffer' }) -- lines in the current buffer
vim.keymap.set('n', '<leader>L', ':Lines<CR>', { silent = true, desc = 'Show lines in the current loaded buffer' }) -- lines in loaded buffer
vim.keymap.set('n', '<leader>/', ':History/<CR>', { silent = true, desc = 'Search history' }) -- search history
vim.keymap.set('n', '<leader><tab>', '<plug>(fzf-maps-n)', { silent = true, desc = 'Show keymaps in normal mode' }) -- show keymaps in normal mode
vim.keymap.set('i', '<leader><tab>', '<plug>(fzf-maps-i)', { silent = true, desc = 'Show keymaps in insert mode' }) -- show keymaps in insert mode
vim.keymap.set('x', '<leader><tab>', '<plug>(fzf-maps-x)', { silent = true, desc = 'Show keymaps in visual mode' }) -- show keymaps in visual mode

vim.keymap.set({'n', 'v'}, '<leader>s', ':call fzf#run({"down": "50%","sink": "botright split"})<CR>', { silent = true, desc = 'Open files in vertical split' })
vim.keymap.set({'n', 'v'}, '<leader>v', ':call fzf#run({"right": winwidth(".") / 2,"sink": "vertical botright split"})<CR>', { silent = true, desc = 'Open files in vertical split' })

vim.keymap.set({'n', 'x'}, 'x', '"_x') -- delete text without changing the registers ("_ black hole register)

vim.cmd([[
  command! -bang HomeFiles call fzf#vim#files('~/', <bang>0)
]])

----------------
--- settings ---
----------------

HOME = os.getenv("HOME")
CACHE = os.getenv("XDG_CACHE_HOME")

-- disable netrw at the very start of our init.lua, because we use nvim-tree
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- Enable 24-bit RGB colors

vim.g.loaded_perl_provider = 0  -- Disable perl provider
vim.g.loaded_ruby_provider = 0  -- Disable ruby provider
vim.g.loaded_node_provider = 0  -- Disable node provider

vim.g.vimsyn_embed = 'l' -- enable highlighting for lua HERE doc inside vim script

-- Mapping
local set = vim.opt

-- basic settings
set.encoding = 'utf-8'
set.backspace = {'indent','eol','start'} -- backspace work on every char in insert mode
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
set.completeopt = {'menuone', 'noselect', 'noinsert'}
set.wildmenu = true                      -- on TAB, complete options for system command
set.history = 1000
set.completeopt = 'menu,menuone,preview' -- show possible completions
set.dictionary = '/usr/share/dict/words' -- word completion with i_CTRL-X_CTRL-K

set.clipboard = {'unnamed','unnamedplus'}

-- Mapping waiting time
set.timeout = false
set.ttimeout = true
set.ttimeoutlen = 100

-- Display
set.showmatch = true   -- show matching brackets
set.scrolloff = 3      -- always show 3 rows from edge of the screen
set.sidescroll = 5     -- minimal number of columns to scroll horizontally
set.sidescrolloff = 15 -- minimal number of columns to keep to the left and o the right
set.synmaxcol = 300    -- stop syntax highligh after x lines for performance
set.laststatus = 2     -- always show status line
set.visualbell = true

set.list = true              -- display white characters
set.listchars = {tab='→ ',trail='·',nbsp='·',precedes='«',extends='»',eol='↲'}
set.foldenable = false
--set.foldlevel = 4            -- limit folding to 4 levels
--set.foldmethod = 'syntax'    -- use language syntax to generate folds
set.foldexpr = 'nvim_treesitter#foldexpr()'
set.wrap = true              -- wrap lines even if very long
set.eol = true               -- show if there's no eol char
set.startofline = false      -- do not move the cursor to the first non-blank of the line
set.showbreak = '↪︎ '         -- character to show when line id broken
set.breakindent = true       -- preserve the indentation of a virtual line
set.breakindentopt = 'sbr'   -- display the 'showbreak' value before applying the additional indent

-- Sidebar
set.number = true            -- line number on the left combined with ...
set.relativenumber = true    -- to show line number + relative number
set.numberwidth = 3          -- always reserve 3 spaces for line number
set.modelines = 0
set.showcmd = true           -- display command in bottom bar
set.showmode = true          -- display current mode down the bottom
set.signcolumn = 'auto'

-- Search
set.incsearch = true    -- starts searching as soon as typing, without enter needed
set.ignorecase = true   -- ignore letter case when searching
set.smartcase = true    -- case insentive unless capitals used in search
set.hlsearch = true     -- hightlight all matches
set.matchtime = 2       -- delay before showing matching parent
set.mps = vim.o.mps .. ",<:>"

-- White characters
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.tabstop = 2             -- 1 tab = 2 spaces
set.shiftwidth = 2          -- indentation rule
set.softtabstop = 2
set.expandtab = true        -- expand tab to spaces
set.formatoptions = 'rqnj1' -- r - auto-insert comment leader on <Enter>; q - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Search
set.ignorecase = true    -- search case insensitive
set.smartcase = true     -- ... but not when search pattern contains upper case characters
set.incsearch = true     -- show match while typing
set.hlsearch = true      -- highligh all matches
set.wildignore = {'*/cache/*', '*/tmp/*', '*/.venv*'}

-- Backup files
set.backup = true                         -- use backup files
set.writebackup = true                    -- backup before overwriting a file
set.swapfile = false                       -- use swap file
set.undofile = true                       -- save history to an undo file
set.undodir = CACHE .. '/nvim/undo//'     -- undo files
set.backupdir = CACHE .. '/nvim/backup//' -- backups
--set.directory = CACHE .. '/nvim/swap//'   -- swap files

-- When opening a window put it right or below the current one
vim.opt.splitright = true  -- Split windows right to the current windows
vim.opt.splitbelow = true  -- Split windows below to the current windows

-- Look for a tag file in the git folder
-- I shouldn't have to use `cwd` but here we are
vim.opt.tags:prepend(string.format('%s/.git/tags', vim.fn.getcwd()))

-- Set grep default grep command with ripgrep
vim.opt.grepprg = 'rg --vimgrep --follow'
vim.opt.errorformat:append('%f:%l:%c%p%m')


-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

-- diagnostics
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setqflist)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --local opts = { buffer = ev.buf }
    --
    -- Mappings.
    local nmap = function(keys, func, desc)
      --if desc then
      --  desc = 'LSP: ' .. desc
      --end
      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
    end

    nmap('n', 'gd', vim.lsp.buf.definition, '[g]oto [d]efinition') -- Jump to the definition
    nmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation') -- Displays hover information about the symbol under the cursor
    nmap('n', 'gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation') -- Lists all the implementations for the symbol under the cursor
    nmap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation') -- Displays a function's signature information
    nmap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd Folder')
    nmap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove Folder')
    nmap('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[w]orkspace [l]ist Folders')
    nmap('n', '<space>D', vim.lsp.buf.type_definition, 'Type [d]efinition') -- Jumps to the definition of the type symbol
    nmap('n', '<space>rn', vim.lsp.buf.rename, '[r]e[n]ame') -- Renames all references to the symbol under the cursor
    nmap('n', '<space>ca', vim.lsp.buf.code_action, '[c]ode [a]ction') -- Selects a code action available at the current cursor position
    nmap('n', 'gr', vim.lsp.buf.references, '[g]oto [r]eferences')
    nmap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, 'Format current buffer with LSP')
    --vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    --vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    --vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)

    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'g{}i', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    --vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    --vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- automatically resize all vim buffers if I resize the terminal window
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- VSCode Dark Theme
--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

-- toggle number
local num_toggle = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
   pattern = "*",
   group = num_toggle,
   callback = function()
      vim.opt.cursorline = true
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
         vim.opt.relativenumber = true
      end
   end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      vim.opt.cursorline = false
      if vim.o.nu then
         vim.opt.relativenumber = false
         vim.cmd "redraw"
      end
   end,
})

-- highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
   pattern = "*",
   group = vim.api.nvim_create_augroup("hl_yank", {}),
   callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
   end,
})

--vim.cmd([[
--set signcolumn=yes
--autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
--]])
