return {
    { 'nvim-treesitter/nvim-treesitter' },
    {
        'L3MON4D3/LuaSnip', dependencies = { 'rafamadriz/friendly-snippets' }
    },
    {
        'neovim/nvim-lspconfig',
        branch = 'v3.x',
        dependencies = {
            { 'VonHeikemen/lsp-zero.nvim' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'mfussenegger/nvim-jdtls',                  ft = 'java' },
            { 'kdheepak/cmp-latex-symbols' },
            { 'hrsh7th/cmp-emoji' },
        }
    },
}
