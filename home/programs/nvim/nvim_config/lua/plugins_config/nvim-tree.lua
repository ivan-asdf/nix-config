-- required for opening of dirs automatically
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- auto close if last window https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
-- remap open horizontal and open vertical
local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  --api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  -- replaces api.node.run.system
  vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
end
-- have explored all optionns upto nvim-tree.trash
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  sort_by = "case_sensetive",
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    add_trailing = true,
    highlight_opened_files = "name",
    indent_markers = {
      enable = true,
      inline_arrows = false,
      icons = {
        item = "┝",
        corner = "┕",
        --item = "┣",
        --corner = "┗",
        --edge =  "┃"
        --item = "├"
      },
    },
    icons = {
      show = {
        folder_arrow = false
      },
    }
  },
  filters = {
    dotfiles = true,
  },
  view = {
    --number = true;
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
      }
    }
  },
  diagnostics = {
    enable = true
  },
  on_attach = my_on_attach
})
require('nvim-web-devicons').setup()

