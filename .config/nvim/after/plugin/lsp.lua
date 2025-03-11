local lsp_zero = require('lsp-zero')
lsp_zero.preset('lsp-only').setup()

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_attach = function(client, bufnr)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'yamlls', 'pylsp', 'gopls', 'jdtls' },
    handlers = {
        function(server_name)
            if server_name ~= 'jdtls' then
                require('lspconfig')[server_name].setup({
                    on_attach = lsp_attach,
                    capabilities = lsp_capabilities
                })
            end
        end,
        jdtls = lsp_zero.noop,
    },
})

require('mason-tool-installer').setup({
    -- Install these linters, formatters, debuggers automatically
    ensure_installed = {
        'java-debug-adapter',
        'java-test',
    },
})


local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                disable = { "undefined-global" },
            },
        }
    },
}

lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            configurationSources = { "pycodestyle" },
            plugins = {
                pycodestyle = {
                    ignore = { "E501" } -- line too long
                }
            }
        }
    }
}

configs.ast_grep = {
    default_config = {
        cmd = { 'ast-grep', 'lsp' },
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern('sgconfig.yml'),
    },
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.o.updatetime = 3000
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" },
--     {
--         group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
--         callback = function()
--             vim.diagnostic.open_float(nil, { focus = false })
--         end
--     }
-- )

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        local telescope = require('telescope.builtin')
        local ivy = require('telescope.themes').get_ivy({})

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- vim.keymap.set('n', 'gd', function() telescope.lsp_definitions(ivy) end)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        vim.keymap.set('n', 'gI', function() telescope.lsp_implementations(ivy) end)

        -- vim.keymap.set('n', 'gr', function() telescope.lsp_references(ivy) end)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set('n', '<space>d', function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end)
    end,
})

vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('UserLspDetach', { clear = true }),
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})
