return {
    { "ellisonleao/gruvbox.nvim" },
    { "sainnhe/gruvbox-material" },
    { 'kvrohit/rasmus.nvim' },
    { 'savq/melange-nvim' },
    { "EdenEast/nightfox.nvim" },
    { "catppuccin/nvim",              name = "catppuccin" },
    { "scottmckendry/cyberdream.nvim" },
    { "navarasu/onedark.nvim", },
    { "ribru17/bamboo.nvim" },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            overrides = function(colors)
                local theme = colors.theme.syn
                return {
                    markdownBold = { fg = theme.constant, bold = true },
                }
            end,
        }
    },
}
