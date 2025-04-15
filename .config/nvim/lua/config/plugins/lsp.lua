return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        opts = {
            ensure_installed = { "c", "lua", "java", "javascript", "go", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    },
    {
        'neovim/nvim-lspconfig',
        branch = 'v3.x',
        lazy = false,
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'VonHeikemen/lsp-zero.nvim' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'yamlls', 'pylsp', 'gopls', 'jdtls' },
                handlers = {
                    function(server_name)
                        if server_name ~= 'jdtls' then
                            require('lspconfig')[server_name].setup({
                                on_attach = function(_, _)
                                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
                                end,
                                capabilities = require('cmp_nvim_lsp').default_capabilities()
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

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    local telescope = require('telescope.builtin')
                    local ivy = require('telescope.themes').get_ivy({})

                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                    vim.keymap.set('n', 'gI', function() telescope.lsp_implementations(ivy) end)

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
        end
    },
    {
        'mfussenegger/nvim-jdtls',
        enabled = false,
        ft = 'java'
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            { 'VonHeikemen/lsp-zero.nvim' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-emoji' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'kdheepak/cmp-latex-symbols' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        lazy = false,
        config = function()
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
        end
    },
}
