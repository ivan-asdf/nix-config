vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoread = true
vim.opt.scrolloff=8

vim.cmd([[set expandtab]])

vim.cmd([[set noswapfile]])
vim.cmd([[set nobackup]])
vim.cmd([[set nu]])
vim.cmd([[set relativenumber]])
--vim.cmd([[set nohlsearch]])
vim.cmd([[set incsearch]])
vim.cmd([[set nowrap]])
--vim.cmd([[set signcolumn=yes]])
vim.cmd([[set colorcolumn=80]])
vim.cmd([[set cmdheight=2]])
vim.cmd([[set updatetime=50]])

vim.o.background = "light"
-- vim.cmd([[colorscheme onedark]])
vim.cmd.colorscheme 'catppuccin'
-- vim.cmd([[set splitbelow]])
-- vim.cmd([[termwinsize=10x0]])
vim.cmd([[highlight iCursor guifg=pink guibg=red]])
vim.cmd([[set guicursor=i:block-iCursor]])
vim.cmd([[set guicursor+=i:blinkon1-iCursor/iCursor]])
