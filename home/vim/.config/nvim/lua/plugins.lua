local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('Installing packer...')
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
    vim.cmd [[packadd packer.nvim]]
    print('Done')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

--local status_ok, packer = pcall(require, 'packer')
--if not status_ok then
--  return
--end

--packer.init({
--  display = {
--    open_fn = function()
--      return require('packer.util').float({ border = 'rounded' })
--    end,
--  },
--})

-- Automatically run PackerSync whenever file is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Setup plugins
return require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- auto-completion engine
  use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] } -- the completion plugin

  -- nvim-cmp completion sources
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' } -- path completions
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' } -- buffer completions
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' } -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp' -- lsp completions
  use 'hrsh7th/cmp-nvim-lua' -- lua api completions
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- LSP support
  use 'neovim/nvim-lspconfig'

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- colorscheme
  use 'ellisonleao/gruvbox.nvim'
  --use 'folke/tokyonight.nvim'
  use { 'nvim-lualine/lualine.nvim', config = [[require('config.lualine')]] }

  -- indent blank lines
  use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] }

  -- Highlight URLs inside vim
  use { 'itchyny/vim-highlighturl', event = 'VimEnter' }

  -- FZF
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  use 'junegunn/fzf.vim'
  --use {'junegunn/goyo.vim', config = [[require('config.goyo')]] }

  -- Rainbow Parenthesis
  --use 'junegunn/rainbow_parentheses.vim'

  -- Comment plugin
  use { 'tpope/vim-commentary', event = "VimEnter" }

  -- Multiple cursor plugin like VSCode
  use 'mg979/vim-visual-multi'

  -- Git command inside vim
  use { 'tpope/vim-fugitive', event = 'User InGitRepo', config = [[require('config.fugitive')]] }
  use 'christoomey/vim-conflicted'

  -- Show git change (change, delete, add) signs in vim sign column
  use 'lewis6991/gitsigns.nvim'

  -- EditorConfig
  use { 'editorconfig/editorconfig-vim', config = [[require('config.editorconfig')]] }

  -- IaaC
  --use { 'hashivim/vim-terraform', config = [[require('config.terraform')]] }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
