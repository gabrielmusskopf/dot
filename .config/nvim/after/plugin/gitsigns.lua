local gitsigns = require('gitsigns')

vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk_inline)
vim.keymap.set("n", "]h", gitsigns.next_hunk)
vim.keymap.set("n", "[h", gitsigns.prev_hunk)

gitsigns.setup()
