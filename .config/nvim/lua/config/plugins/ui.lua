return {
    {
        'nvim-tree/nvim-web-devicons',
        lazy = false
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            vim.api.nvim_create_autocmd("BufEnter", {
                desc = 'Attatch colorizer',
                group = vim.api.nvim_create_augroup('AttachColorizer', { clear = true }),
                callback = function()
                    vim.cmd("ColorizerAttachToBuffer")
                end
            })

            vim.api.nvim_create_autocmd("BufLeave", {
                desc = 'Dettatch colorizer',
                group = vim.api.nvim_create_augroup('DettachColorizer', { clear = true }),
                callback = function()
                    vim.cmd("ColorizerDetachFromBuffer")
                end
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        lazy = false,
        config = function()
            local lualine = require("lualine")
            local ayu_mirage = require('lualine.themes.ayu_mirage')
            ayu_mirage.normal.b.bg = 'none'
            ayu_mirage.normal.c.bg = 'none'
            ayu_mirage.insert.b.bg = 'none'
            ayu_mirage.visual.b.bg = 'none'

            lualine.setup {
                options = {
                    theme = ayu_mirage,
                    icons_enabled = true,
                    component_separators = '|',
                    section_separators = '',
                }
            }
        end
    },
    {
        "preservim/vim-pencil",
        ft = { 'markdown', 'md' },
        config = function()
            vim.g['pencil#conceallevel'] = 2

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('Apply Pencil to markdown', { clear = true }),
                pattern = { 'markdown', 'mkd', 'text' },
                callback = function()
                    vim.cmd("SoftPencil")
                end,
            })
        end
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        keys = {
            { "<leader>pv", "<cmd>Oil<CR>" }
        },
        opts = {
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            view_options = {
                show_hidden = true,
            },
            use_default_keymaps = false,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                -- ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        keys = {
            { "<leader>z", "<cmd>ZenMode<CR>" }
        },
        opts = {
            window = {
                backdrop = 0.95,
                -- height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                width = 0.85,
                height = 0.9,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                tmux = { enabled = false },
            },
        }
    },
}
