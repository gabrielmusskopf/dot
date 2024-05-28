local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
    print('Something went wrong:', mason)
    return
end

mason.setup()

local status, lsp = pcall(require, 'lsp-zero')
if not status then
    print('Something went wrong:', lsp)
    return
end

lsp.preset('lsp-only').setup()

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.o.updatetime = 3000
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" },
    {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end
    }
)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        local telescope = require('telescope.builtin')
        local ivy = require('telescope.themes').get_ivy({})

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', function() telescope.lsp_definitions(ivy) end)
        vim.keymap.set('n', 'gI', function() telescope.lsp_implementations(ivy) end)
        vim.keymap.set('n', 'gr', function() telescope.lsp_references(ivy) end)

        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    end,
})

vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('UserLspDetach', { clear = true }),
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})

local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    print('Something went wrong:', lspconfig)
    return
end

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                disable = { "undefined-global" },
            },
        }
    },
}

lspconfig.gopls.setup {}
lspconfig.jdtls.setup {}
lspconfig.pyright.setup {}
