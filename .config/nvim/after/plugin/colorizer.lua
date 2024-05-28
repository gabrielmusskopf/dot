vim.api.nvim_create_autocmd("BufEnter", {
    desc = 'Attatch colorizer',
    group = vim.api.nvim_create_augroup('AttachColorizer', { clear = true }),
    callback = function()
        vim.cmd("ColorizerAttachToBuffer")
    end
})


vim.api.nvim_create_autocmd("BufLeave", {
    desc = 'Dettatch colorizer',
    group = vim.api.nvim_create_augroup('DettachColorizer', { clear = true }),
    callback = function()
        vim.cmd("ColorizerDetachFromBuffer")
    end
})
