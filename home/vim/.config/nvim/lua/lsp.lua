-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts) -- Show diagnostics in a floating window
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Move to the previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Move to the next diagnostic
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
 
 
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('n', 'gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration') -- Jump to declaration
  nmap('n', 'gd', vim.lsp.buf.definition, '[g]oto [d]efinition') -- Jump to the definition
  nmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentatio') -- Displays hover information about the symbol under the cursor
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
end
 
 
-- customize diagnostic
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
 
-- customize help windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)
 
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "go", "lua", "python", "rust", "vim", "help" },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- simrat39/rust-tools.nvim
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})


-- bash-language-server
--vim.api.nvim_create_autocmd('FileType', {
--  pattern = 'sh',
--  callback = function()
--    vim.lsp.start({
--      name = 'bash-language-server',
--      cmd = { 'bash-language-server', 'start' },
--    })
--  end,
--})
