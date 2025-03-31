return {
    { 'nvim-tree/nvim-web-devicons' },
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
    { 'nvim-lualine/lualine.nvim',  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true } },
    { "folke/zen-mode.nvim" },
    { "preservim/vim-pencil" },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        lazy = false,
    },

}
