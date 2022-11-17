require 'lspconfig'.tflint.setup()
require 'lspconfig'.terraformls.setup{}
vim.cmd([[
  silent! autocmd! filetypedetect bufread,bufnewfile *.tflint
  autocmd bufread,bufnewfile *.hcl set filetype=hcl
  autocmd bufread,bufnewfile .terraformrc, terraform.rc set filetype=hcl
  autocmd bufread,bufnewfile *.tf, *.tfvars set filetype=terraform
  autocmd bufread,bufnewfile *.tfstate, *.tfstate.backup set filetype=json
]])

-- auto-format on save
vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = { '*.tf', '*.tfvars' }
  callback = function()
    vim.lsp.buf.format()
  end,
})
