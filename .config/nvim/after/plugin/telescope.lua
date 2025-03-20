local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>pk', builtin.keymaps)
vim.keymap.set('n', '<leader>pb', builtin.buffers)
vim.keymap.set('n', '<leader>pf', builtin.find_files)
vim.keymap.set('n', '<leader>ps', builtin.live_grep)

local status, utils = pcall(require, "gabriel.utils")
if status then
    utils.set_hl("TelescopeBorder", { bg = "none" })
end

telescope.setup {
    defaults = require('telescope.themes').get_ivy(),
    extensions = {
        fzf = {}
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob=!.git/", "--sortr=modified" }
        },
        live_grep = {
            additional_args = { "--hidden", "--glob=!.git/", "--sortr=modified" }
        }
    }
}

telescope.load_extension('frecency')
telescope.load_extension('fzf')
