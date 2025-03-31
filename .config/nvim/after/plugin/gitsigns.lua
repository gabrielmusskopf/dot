local status, gitsigns = pcall(require, 'gitsigns')
if not status then
    return
end

vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk_inline)
vim.keymap.set("n", "]h", gitsigns.next_hunk)
vim.keymap.set("n", "[h", gitsigns.prev_hunk)

local utils = require("config.utils")

utils.set_hl("GitSignsAdd", { bg = "none" })
utils.set_hl("GitSignsChange", { bg = "none" })
utils.set_hl("GitSignsDelete", { bg = "none" })

gitsigns.setup()
