local opts = { noremap = true, silent = true }
--vim.api.nvim_set_keymap("", "<F5>", ":!go run . <Enter>", opts)
vim.api.nvim_set_keymap("", "<C-n>", ":NvimTreeToggle<Enter>", opts)
vim.api.nvim_set_keymap("", "<F5>", ":TermExec go_back=0 cmd='go run .'<Enter>", opts)
vim.api.nvim_set_keymap("v", "<Tab>", ">gb", opts)
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", opts)

require('plugins_config.lsp.lspconfig/maps')

vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
