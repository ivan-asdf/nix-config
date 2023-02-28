local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'Ivan-Asdf/onedark.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  -- use 'Mofiqul/vscode.nvim'
  --use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
  --require("toggleterm").setup()
  --end}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'windwp/nvim-ts-autotag'
  }
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use {'konapun/vacuumline.nvim', requires = {
    'glepnir/galaxyline.nvim', branch = 'main',
    'kyazdani42/nvim-web-devicons', opt = true
  }, config = function() require('vacuumline').setup() end} -- Add this line to use defaults; otherwise, call `setup` with your config as described below wherever you configure your plugins

  if packer_bootstrap then
    require('packer').sync()
  end
end)
