local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>pk', builtin.keymaps)
vim.keymap.set('n', '<leader>pb', builtin.buffers)
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({ hidden = true, follow = true })
end)
vim.keymap.set('n', '<leader>ps', function()
    builtin.live_grep({
        cwd = vim.g.first_path,
        additional_args = { "--hidden", "--glob=!.git/" },
    })
end)

local status, utils = pcall(require, "gabriel.utils")
if status then
    utils.set_hl("TelescopeBorder", { bg = "none" })
end

telescope.setup {
    -- https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
    defaults = vim.tbl_extend(
        "force",
        require('telescope.themes').get_ivy({}),
        {
            -- custom configs
        }),
    extensions = {
        fzf = {}
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--sortr=modified" }
        }
    }
}

telescope.load_extension('frecency')
telescope.load_extension('fzf')
