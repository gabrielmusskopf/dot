local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>hk', builtin.keymaps)
vim.keymap.set('n', '<leader>pb', builtin.buffers)

vim.keymap.set('n', '<leader>pf', telescope.extensions.frecency.frecency)
--builtin.find_files(themes.get_ivy({ , hidden = true, follow = true }))
--
vim.keymap.set('n', '<leader>ps', function()
    builtin.live_grep({
        cwd = vim.g.first_path,
        additional_args = { "--hidden", "--glob=!.git/" },
    })
end)

telescope.setup {
    -- https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
    defaults = vim.tbl_extend(
        "force",
        require('telescope.themes').get_ivy({}),
        {
            -- custom configs
        })
}

telescope.load_extension('frecency')
