local lsp_zero = require('lsp-zero')
lsp_zero.preset('lsp-only').setup()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'yamlls', 'pylsp', 'gopls', 'jdtls' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        jdtls = lsp_zero.noop,
    },
})


local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                disable = { "undefined-global" },
            },
        }
    },
}

-- lspconfig.jdtls.setup {
--     setup = {
--         jdtls = function(_, opts)
--             vim.api.nvim_create_autocmd("FileType", {
--                 pattern = "java",
--                 callback = function()
--                     require("lazyvim.util").on_attach(function(_, buffer)
--                         vim.keymap.set(
--                             "n",
--                             "<leader>di",
--                             "<Cmd>lua require'jdtls'.organize_imports()<CR>",
--                             { buffer = buffer, desc = "Organize Imports" }
--                         )
--                         vim.keymap.set(
--                             "n",
--                             "<leader>dt",
--                             "<Cmd>lua require'jdtls'.test_class()<CR>",
--                             { buffer = buffer, desc = "Test Class" }
--                         )
--                         vim.keymap.set(
--                             "n",
--                             "<leader>dn",
--                             "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
--                             { buffer = buffer, desc = "Test Nearest Method" }
--                         )
--                         vim.keymap.set(
--                             "v",
--                             "<leader>de",
--                             "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
--                             { buffer = buffer, desc = "Extract Variable" }
--                         )
--                         vim.keymap.set(
--                             "n",
--                             "<leader>de",
--                             "<Cmd>lua require('jdtls').extract_variable()<CR>",
--                             { buffer = buffer, desc = "Extract Variable" }
--                         )
--                         vim.keymap.set(
--                             "v",
--                             "<leader>dm",
--                             "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
--                             { buffer = buffer, desc = "Extract Method" }
--                         )
--                         vim.keymap.set(
--                             "n",
--                             "<leader>cf",
--                             "<cmd>lua vim.lsp.buf.formatting()<CR>",
--                             { buffer = buffer, desc = "Format" }
--                         )
--                     end)
--
--                     local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
--                     local workspace_dir = "/home/gabrielmusskopf/.cache/jdtls/workspace/" ..
--                     vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--                     local configuration = jdtls_path .. "/config_linux"
--                     local jar = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar"
--                     local lombok = jdtls_path .. "/lombok.jar"
--
--                     local config = {
--                         cmd = {
--
--                             "java",
--
--                             "-javaagent:" .. lombok,
--                             "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--                             "-Dosgi.bundles.defaultStartLevel=4",
--                             "-Declipse.product=org.eclipse.jdt.ls.core.product",
--                             "-Dlog.protocol=true",
--                             "-Dlog.level=ALL",
--                             -- '-noverify',
--                             "-Xms1g",
--                             "--add-modules=ALL-SYSTEM",
--                             "--add-opens", "java.base/java.util=ALL-UNNAMED",
--                             "--add-opens", "java.base/java.lang=ALL-UNNAMED",
--                             "-jar", vim.fn.glob(jar),
--                             "-configuration", configuration,
--                             "-data", workspace_dir,
--                         },
--
--                         root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
--
--                         settings = {
--                             java = {},
--                         },
--                         handlers = {
--                             ["language/status"] = function(_, result)
--                                 -- print(result)
--                             end,
--                             ["$/progress"] = function(_, result, ctx)
--                                 -- disable progress updates.
--                             end,
--                         },
--                     }
--
--                     print("lsp.lua")
--                     require("jdtls").start_or_attach(config)
--                 end,
--             })
--             return true
--         end,
--     }
-- }
--
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
