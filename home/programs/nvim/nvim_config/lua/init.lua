-- Package managers
require('manager.lazy')
--require('manager.packer')

-- Non-plugin nvim configuration
require('options')
require('maps')

-- File navigation
require('plugins_config.nvim-tree')

-- Good syntax highlighting
require('plugins_config.nvim-treesitter')

-- Inbuild nvim lsp client configuration
-- Features: highlight errors, jump declartions/definitions/references, renaming
require('plugins_config.lsp.lspconfig/lspconfigs')

-- Show autocomplete popups
require('plugins_config.lsp.nvim-cmp')

-- Colors color hashes #22AA33;
require('nvim-highlight-colors').setup {}
-- Shows modified lines
require('gitsigns').setup()
-- Nvim line at bottom
require('lualine').setup {}

-- Language server downloader/package manager
require("mason").setup()
require("mason-lspconfig").setup()

-- require('onedark').setup {
-- style = 'light'
--}
