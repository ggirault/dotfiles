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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Setup plugins
require('packer').startup({function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'neovim/nvim-lspconfig' -- LSP support

  use { -- the completion plugin
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp' ,'L3MON4D3/LuaSnip' },
  }

  -- nvim-cmp completion sources
  use { -- path completions
    'hrsh7th/cmp-path',
    after = 'nvim-cmp' 
  }
  use { -- buffer completions
    'hrsh7th/cmp-buffer',
    after = 'nvim-cmp' 
  }
  use { -- cmdline completions
    'hrsh7th/cmp-cmdline',
    after = 'nvim-cmp' 
  }
  use 'hrsh7th/cmp-nvim-lua' -- lua api completions

  use { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    run = function() pcall(require('nvim-treesitter.install').update { with_sync = true }) end
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  
  use 'ellisonleao/gruvbox.nvim' -- colorscheme
  use { 'nvim-lualine/lualine.nvim' } -- better status line
  use { 'akinsho/bufferline.nvim' } -- show tabs
  use { 'lukas-reineke/indent-blankline.nvim' } -- indent blank lines

  use { -- Highlight URLs inside vim
    'itchyny/vim-highlighturl',
    event = 'VimEnter' 
  }

  use { -- FZF
    'junegunn/fzf',
    run = ':call fzf#install()' 
  }
  use 'junegunn/fzf.vim'
  
  use { -- Comment plugin
    'tpope/vim-commentary',
    event = "VimEnter"
  }

  --use 'mg979/vim-visual-multi' -- Multiple cursor plugin like VSCode

  use 'lewis6991/gitsigns.nvim' -- Show git change (change, delete, add) signs in vim sign column

  -- Languages
  --use { 'hashivim/vim-terraform' } -- terraform
  use { -- bash
    'bash-lsp/bash-language-server',
    config = function() require('lspconfig').bashls.setup{} end
  }

  -- Rust
  use 'simrat39/rust-tools.nvim' -- rust
  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

