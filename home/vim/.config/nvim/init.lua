require('settings')
require('colorscheme')
require('keymaps')
require('plugins')
require('lsp')

local vim_files = {
  'autocommands.vim'
}

-- source vim files
for _, name in ipairs(vim_files) do
  local path = string.format("%s/lua/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
