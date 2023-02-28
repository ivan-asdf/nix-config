local opts = { noremap = true, silent = true }
--vim.api.nvim_set_keymap("", "<F5>", ":!go run . <Enter>", opts)
vim.api.nvim_set_keymap("", "<C-n>", ":NvimTreeToggle<Enter>", opts)
vim.api.nvim_set_keymap("", "<F5>", ":TermExec go_back=0 cmd='go run .'<Enter>", opts)
vim.api.nvim_set_keymap("v", "<Tab>", ">gb", opts)
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", opts)


