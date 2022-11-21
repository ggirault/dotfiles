vim.g.mapleader = ','
vim.g.malocalpleader = '\\'

local map = vim.keymap.set

-- FZF
map('n', '<leader>f', ':GFiles<CR>', { silent = true, desc = 'Show all git files' }) -- git files
map('n', '<leader>F', ':Files<CR>', { silent = true, desc = 'Show files in current path' }) -- files
map('n', '<leader>H', ':HomeFiles<CR>', { silent = true, desc = 'Show files from HOME directory' }) -- files
map('n', '<leader>?', ':GFiles?<CR>', { silent = true, desc = 'git status' }) -- git status
map('n', '<leader>b', ':Buffers<CR>', { silent = true, desc = 'Show open buffers' }) -- open buffers
map('n', '<leader>l', ':BLines<CR>', { silent = true, desc = 'Show lines in the current buffer' }) -- lines in the current buffer
map('n', '<leader>L', ':Lines<CR>', { silent = true, desc = 'Show lines in the current loaded buffer' }) -- lines in loaded buffer
map('n', '<leader>/', ':History/<CR>', { silent = true, desc = 'Search history' }) -- search history
map('n', '<leader><tab>', '<plug>(fzf-maps-n)', { silent = true, desc = 'Show keymaps in normal mode' }) -- show keymaps in normal mode
map('i', '<leader><tab>', '<plug>(fzf-maps-i)', { silent = true, desc = 'Show keymaps in insert mode' }) -- show keymaps in insert mode
map('x', '<leader><tab>', '<plug>(fzf-maps-x)', { silent = true, desc = 'Show keymaps in visual mode' }) -- show keymaps in visual mode

map({'n', 'v'}, '<leader>s', ':call fzf#run({"down": "50%","sink": "botright split"})<CR>', { silent = true, desc = 'Open files in vertical split' })
map({'n', 'v'}, '<leader>v', ':call fzf#run({"right": winwidth(".") / 2,"sink": "vertical botright split"})<CR>', { silent = true, desc = 'Open files in vertical split' })

--map('n', '<leader>y', '"*y', { silent = true})
--map('n', '<leader>Y', '"+y', { silent = true})

map({'n', 'x'}, 'x', '"_x') -- delete text without changing the registers ("_ black hole register)

vim.cmd([[
  command! -bang HomeFiles call fzf#vim#files('~/', <bang>0)
]])

-- ==== CONF TO REFACTOR ====

local opts = { noremap = true, silent = true }
 
local term_opts = { silent = true }
 
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   '': Yes, an empty string. Is the equivalent of n + v + o.
 
-- Clipboard --
keymap("", "<Leader>y", "*y", term_opts)
keymap("", "<Leader>Y", "+y", term_opts)
keymap("", "<Leader>p", "*p", term_opts)
keymap("", "<Leader>P", "+p", term_opts)
--keymap({'n', 'x'}, 'x', '"_x', opts)
 
-- Quit --
keymap("n", "<C-q>", "<Esc>:q<CR>", opts)
keymap("i", "<C-q>", ":q<CR>", opts)
 
-- Save --
keymap("n", "<C-s>", ":update<CR>", opts)
keymap("i", "<C-s>", "<C-O>:update<CR>", opts)
 
-- Search --
 
--#vim.opt.fzf_action = {'ctrl-t'='tab split', 'ctrl-x'='split', 'ctrl-v'='vsplit'}
 
 
-- nvim-lspconfig Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts) -- Show diagnostics in a floating window
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Move to the previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Move to the next diagnostic
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
 
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
 
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts) -- Jump to declaration
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- Jump to the definition
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- Displays hover information about the symbol under the cursor
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) -- Lists all the implementations for the symbol under the cursor
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts) -- Displays a function's signature information
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts) -- Jumps to the definition of the type symbol
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts) -- Renames all references to the symbol under the cursor
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts) -- Selects a code action available at the current cursor position
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

