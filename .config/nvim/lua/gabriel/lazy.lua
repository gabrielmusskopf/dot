local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { "ellisonleao/gruvbox.nvim" },
    { "sainnhe/gruvbox-material" },
    { 'kvrohit/rasmus.nvim' },
    { 'savq/melange-nvim' },
    { "EdenEast/nightfox.nvim" },
    { "catppuccin/nvim",                name = "catppuccin" },
    { "scottmckendry/cyberdream.nvim" },
    { "navarasu/onedark.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "ribru17/bamboo.nvim" },
    { 'numToStr/Comment.nvim',          lazy = false },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-lua/plenary.nvim' },
    { 'ThePrimeagen/harpoon' },
    { 'mbbill/undotree' },
    { 'christoomey/vim-tmux-navigator' },
    { 'norcalli/nvim-colorizer.lua' },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        }
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', opt = true } },
    { "okuuva/auto-save.nvim" },
    { "folke/zen-mode.nvim" },
    { "preservim/vim-pencil" },
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-surround" },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        cond = vim.fn.getcwd() == vim.fn.expand("~/notes"),
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown", "md" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    { "nvim-telescope/telescope-frecency.nvim" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        lazy = false,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        ft = { "markdown", "md" },
        opts = {},
    },

    -- LSP
    { 'mfussenegger/nvim-jdtls',                  ft = 'java' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',                branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { "rafamadriz/friendly-snippets" },
    { 'L3MON4D3/LuaSnip',                         dependencies = { 'rafamadriz/friendly-snippets' } },
})
