return {
    {
        'okuuva/auto-save.nvim',
        config = function()
            local autosave = require 'auto-save'

            autosave.setup({
                debounce_delay = 15000,
            })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'AutoSaveWritePost',
                group = vim.api.nvim_create_augroup('autosave', {}),
                callback = function(opts)
                    if opts.data.saved_buffer ~= nil then
                        vim.notify('saved at ' .. vim.fn.strftime('%H:%M:%S'), vim.log.levels.INFO)
                    end
                end,
            })
        end
    }
}
