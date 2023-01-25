--require 'lspconfig'.tflint.setup()
require 'lspconfig'.terraformls.setup{}
vim.cmd([[
  silent! autocmd! filetypedetect BufRead,BufNewFile *.tflint
  autocmd BufRead,BufNewFile *.hcl set filetype=hcl
  autocmd BufRead,BufNewFile terraform.rc set filetype=hcl
  autocmd BufRead,BufNewFile .terraformrc set filetype=hcl
  autocmd BufRead,BufNewFile *.tf set filetype=terraform
  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
  autocmd BufRead,BufNewFile *.tfstate set filetype=json
  autocmd BufRead,BufNewFile *.tfstate.backup set filetype=json
  autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()
  autocmd BufWritePre *.tfvars lua vim.lsp.buf.formatting_sync()
]])

-- auto-format on save
--vim.api.nvim_create_autocmd({'BufWritePre'}, {
--  pattern = { '*.tf', '*.tfvars' },
--  callback = vim.lsp.buf.formatting_sync,
--})
