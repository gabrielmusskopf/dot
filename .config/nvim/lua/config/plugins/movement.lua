return {
    {
        'numToStr/Comment.nvim',
        event = 'BufReadPre',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'ThePrimeagen/harpoon',
        lazy = false,
        config = function()
            local mark = require 'harpoon.mark'
            local ui = require 'harpoon.ui'

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-w>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-i>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-o>", function() ui.nav_file(4) end)
            vim.keymap.set("n", "<leader>]", function() ui.nav_next() end)
            vim.keymap.set("n", "<leader>[", function() ui.nav_prev() end)
        end
    },
    {
        'mbbill/undotree',
        event = 'BufReadPre',
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>" }
        }
    },
    { 'christoomey/vim-tmux-navigator' },
    {
        "tpope/vim-surround",
        event = 'BufReadPre',
        keys = {
            { "<leader>bb", "ysiw*" }
        }
    },
}
