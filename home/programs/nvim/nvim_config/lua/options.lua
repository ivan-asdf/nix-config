vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoread = true
vim.opt.scrolloff = 8

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
vim.cmd([[filetype plugin indent on]])

-- vim.cmd([[colorscheme onedark]])
vim.o.termguicolors = true
vim.o.background = "light"
vim.cmd.colorscheme 'catppuccin'
-- vim.cmd([[set splitbelow]])
-- vim.cmd([[termwinsize=10x0]])
vim.o.cursorline = true
-- vim.cmd([[highlight iCursor guifg=pink guibg=red]]) -- what dis do?
-- vim.cmd([[set guicursor=i:block-iCursor]])
--vim.cmd([[set guicursor=i:block-Cursor]])
-- vim.cmd([[set guicursor+=i:blinkon1-iCursor/iCursor]])

vim.cmd([[
  " Add additional file extensions to be recongnised as json
  augroup filetype_blkx
    autocmd!
    autocmd BufRead,BufNewFile *.blkx set filetype=json
  augroup END
  " By default all folds are closed when opening a file. This makes them all open
  autocmd BufReadPost,FileReadPost * normal zR
]])
-- vim.opt.foldmethod = "indent"
-- Use treesitter for folding
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart=99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
