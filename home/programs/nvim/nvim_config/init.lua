require('plugins')
require('options')
require('maps')

function return_to_past_window()
	-- vim.call([[:exe normal <c-w><c-p]])
	-- vim.api.nvim_command('wincmd p')
end

-- require('onedark').setup {
	 -- style = 'light'
--}
require('nvim-highlight-colors').setup {}

require('gitsigns').setup()

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
  vim.keymap.set('n', 'v', api.node.open.vertical,                opts('Open: Vertical Split'))
  -- replaces api.node.run.system
  vim.keymap.set('n', 's', api.node.open.horizontal,              opts('Open: Horizontal Split'))
end
-- have explored all optionns upto nvim-tree.trash
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true;
  sort_by = "case_sensetive",
  update_focused_file = {
    enable = true;
  },
  git = {
    enable = true;
    show_on_dirs = true;
    show_on_open_dirs = false;
  },
  modified = {
    enable = true;
    show_on_dirs = true;
    show_on_open_dirs = false;
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    add_trailing = true,
    highlight_opened_files = "name";
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
--require("toggleterm").setup{
	--open_mapping = [[<C-t>]]
--}
require('lualine').setup()

-- vim.g.nvim_tree_show_icons = {git = 1, folders =  0, files = 0, folder_arrows = 0}
function _G.set_terminal_keymaps()
	local opts = {noremap = true} vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts) vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end


-- call add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "c", "cpp", "lua", "rust", "go", "html", "javascript", "css", "nix" },
	autotag = {
		enable = true,
	},
  auto_install = true,

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = { 
    enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
require('nvim-ts-autotag').setup()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require('lspconfig')['rust_analyzer'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {}
	}
}
-- css ls and snipets
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
--require'lspconfig'.rnix.setup{}
require'lspconfig'.nil_ls.setup {
	on_attach = on_attach,
	flags = lsp_flags,
  settings = {
    ['nil'] = {
      testSetting = 42,
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
}

local servers = { 'pyright', 'gopls', 'cssls', 'clangd', 'lua_ls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
	  flags = lsp_flags
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
