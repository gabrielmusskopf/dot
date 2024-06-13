-- Para não conflitar com epwalsh/obsidian.nvim
vim.g['pencil#conceallevel'] = 2

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('Apply Pencil to markdown', { clear = true }),
    pattern = { 'markdown', 'mkd', 'text' },
    callback = function()
        vim.cmd("SoftPencil")
    end,
})
