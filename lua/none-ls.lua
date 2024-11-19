local null_ls = require("null-ls")

-- Define the group for LSP formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Configuration options for null-ls
local opts = {
    sources = {
        -- C/C++ formatting
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 100}" } -- Example: Use Google style
        }),
        
        -- Lua formatting
        null_ls.builtins.formatting.stylua,

        -- Python formatting
        null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "88" }
        }),

        -- JavaScript/TypeScript formatting
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "css", "json", "yaml", "markdown" }
        }),

        -- Shell script formatting
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4" } -- Indentation set to 4 spaces
        }),

        -- YAML/JSON formatting
        null_ls.builtins.formatting.yamlfmt,
    },

    on_attach = function(client, bufnr)
        -- Set up auto-formatting on save if the LSP supports it
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
}

-- Register null-ls
require("null-ls").setup(opts)

