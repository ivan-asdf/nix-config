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
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  cmd = { "json-languageserver", "--stdio" }
}
require 'lspconfig'.html.setup {
  capabilities = capabilities,
  filetypes = {
    'html', 'templ'
  },
  init_options =
  {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  settings = {
    html = {
      -- printWidth = 80, -- Wrap lines at 80 characters
      format = {
        templating = true,
        wrapLineLength = 100,
        wrapAttributes = 'aligned-multiple',
      },
      hover = {
        documentation = true,
        references = true,
      },
    }
  }
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
require 'lspconfig'.pyright.setup {
  -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
  -- on_attach = on_attach,
  settings = {
    pyright = {
      autoImportCompletion = true, },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off' }
    }
  }
}
-- make golang "Organize imports" on save
require 'lspconfig'.gopls.setup {
  on_attach = function()
    -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1128115341
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.go" },
      callback = function()
        local params = vim.lsp.util.make_range_params(nil, "utf-16")
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
            else
              vim.lsp.buf.execute_command(r.command)
            end
          end
        end
      end,
    })
  end,
  -- filetypes = {"go", "gomod", "gowork", "gotmpl", "templ"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}
local servers = { 'solargraph', 'cssls', 'bashls', 'texlab', 'tsserver', 'clangd', 'csharp_ls', 'templ' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    flags = lsp_flags
  }
end

vim.filetype.add({ extension = { templ = "templ" } })

require('lspconfig').htmx.setup({
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

require 'lspconfig'.tailwindcss.setup {
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        htmlangular = "html",
        templ = "html"
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}

local custom_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    -- other configuration options
    vim.keymap.set("n", "<leader>lf", custom_format, opts)
end
