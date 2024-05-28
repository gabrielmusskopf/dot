local zenmode = require('zen-mode')

vim.keymap.set("n", "<leader>z", zenmode.toggle)

zenmode.setup({
    window = {
        backdrop = 0.95,
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 0.6,
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
        tmux = { enabled = true },
    },
})
