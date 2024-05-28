local themes_status, themes = pcall(require, 'telescope.themes')
if not themes_status then
    print('Something went wrong:', themes)
end

local builtin_status, builtin = pcall(require, 'telescope.builtin')
if not builtin_status then
    print('Something went wrong:', builtin)
end


vim.keymap.set('n', '<leader>hk', function() builtin.keymaps(themes.get_ivy({})) end)
vim.keymap.set('n', '<leader>pf', function() builtin.find_files(themes.get_ivy({ cwd = vim.g.first_path })) end, {})
vim.keymap.set('n', '<leader>pb', function() builtin.buffers(themes.get_ivy({})) end)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string(themes.get_ivy({ cwd = vim.g.first_path, search = vim.fn.input("Grep > ") }))
end)

--require("telescope").load_extension "file_browser"
require('telescope').setup {
    defaults = {
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
                        {
                            'catimg', filepath
                        },
                        { on_stdout = send_output, stdout_buffered = true, pty = true })
                else
                    require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                        "Binary cannot be previewed")
                end
            end
        },
    },
--    extensions = {
--        file_browser = {
--            theme = "ivy",
--            -- disables netrw and use telescope-file-browser in its place
--            hijack_netrw = true,
--            depth = 20,
--            mappings = {
--                ["i"] = {
--                    -- your custom insert mode mappings
--                },
--                ["n"] = {
--                    -- your custom normal mode mappings
--                },
--            },
--        },
--    },
}
