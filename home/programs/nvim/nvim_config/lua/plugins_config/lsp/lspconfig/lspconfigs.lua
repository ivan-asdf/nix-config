local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['rust_analyzer'].setup {
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
require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  cmd = { "json-languageserver", "--stdio" }
}

--require'lspconfig'.rnix.setup{}
require 'lspconfig'.nil_ls.setup {
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

require 'lspconfig'.lua_ls.setup {
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      },
    },
  },
}

local servers = { 'pyright', 'solargraph', 'gopls', 'cssls', 'clangd', 'bashls', 'texlab' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    flags = lsp_flags
  }
end
