require("mason").setup()
require("mason-lspconfig").setup()

local lsp = require('lsp-zero').preset({ 'recommended' })

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
    'ts_ls',
    'eslint',
    'rust_analyzer',
    'csharp_ls',
    'cssls',
    'pylsp',
    'html',
    'pyright',
})
require 'lspconfig'.pylyzer.setup {}
require 'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 100
                }
            }
        }
    }
}
require 'lspconfig'.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    lsp.on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs( -4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})
lsp.setup()
