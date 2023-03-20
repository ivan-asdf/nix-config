require('manager.lazy')
--require('manager.packer')
require('options')
require('maps')
require('plugins_config.nvim-tree')
require('plugins_config.nvim-treesitter')
require('plugins_config.lsp.lspconfig')
require('plugins_config.lsp.nvim-cmp')
-- require('onedark').setup {
-- style = 'light'
--}
require('nvim-highlight-colors').setup {}
require('gitsigns').setup()
require('lualine').setup {}

require("mason").setup()
require("mason-lspconfig").setup()
