local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    --null_ls.builtins.formatting.stylua,
    --null_ls.builtins.diagnostics.eslint,
    --null_ls.builtins.completion.spell,

    -- Python
    --null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "79", "--preview" }
    }),
    null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.formatting.ruff,
    --null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.djlint,
  },
  diagnostics_format = "#{m} (#{s})",
  fallback_severity = vim.diagnostic.severity.INFO
})
