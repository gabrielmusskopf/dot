-- local ok, surround = pcall(require, 'surround')
-- if not ok then
--     print("vim-surround not found")
--     return
-- end

vim.keymap.set("n", "<leader>bb", 'ysiw*')
