local cmp = require('cmp')
local config = cmp.config
local mapping = cmp.mapping
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format({ details = true })

require("luasnip.loaders.from_lua").lazy_load()
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    preselect = 'item',
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = config.window.bordered(),
        documentation = config.window.bordered(),
    },
    mapping = mapping.preset.insert({
        ['<Tab>'] = cmp_action.luasnip_jump_forward(),
        ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
        ['<C-Space>'] = mapping.complete(),
        ['<C-e>'] = mapping.abort(),
        ['<CR>'] = mapping.confirm({ select = false }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'latex_symbols' },
        { name = 'emoji' },
    }),
    formatting = cmp_format
})
