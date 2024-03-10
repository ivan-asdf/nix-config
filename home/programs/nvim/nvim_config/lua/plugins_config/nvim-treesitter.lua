-- This plugin is just for better highlight

-- call add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "rust", "go", "html", "javascript", "css", "nix", "python", "kdl" },
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
