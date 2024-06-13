local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>hk', builtin.keymaps)
vim.keymap.set('n', '<leader>pb', builtin.buffers)
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files(themes.get_ivy({ cwd = vim.g.first_path, hidden = true, follow = true }))
end)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string(themes.get_ivy({ cwd = vim.g.first_path, search = vim.fn.input("Grep > ") }))
end)

require('telescope').setup {
    -- https://github.com/nvim-telescope/telescope.nvim/issues/848#issuecomment-1584291014
    defaults = vim.tbl_extend(
        "force",
        require('telescope.themes').get_ivy({}),
        {
            preview = {
                mime_hook = function(filepath, bufnr, opts)
                    local is_image = function(fp)
                        local image_extensions = { 'png', 'jpg' } -- Supported image formats
                        local split_path = vim.split(fp:lower(), '.', { plain = true })
                        local extension = split_path[#split_path]
                        return vim.tbl_contains(image_extensions, extension)
                    end
                    if is_image(filepath) then
                        local term = vim.api.nvim_open_term(bufnr, {})
                        local function send_output(_, data, _)
                            for _, d in ipairs(data) do
                                vim.api.nvim_chan_send(term, d .. '\r\n')
                            end
                        end
                        vim.fn.jobstart(
                            { 'catimg', filepath },
                            { on_stdout = send_output, stdout_buffered = true, pty = true })
                    else
                        require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                            "Binary cannot be previewed")
                    end
                end
            },
        })
}
