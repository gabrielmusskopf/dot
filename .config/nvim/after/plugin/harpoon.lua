local mark_status, mark = pcall(require, 'harpoon.mark')
if not mark_status then
    print('Something went wrong:', mark)
end

local ui_status, ui = pcall(require, 'harpoon.ui')
if not ui_status then
    print('Something went wrong:', ui)
end

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-w>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-i>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-o>", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>]", function() ui.nav_next() end)
vim.keymap.set("n", "<leader>[", function() ui.nav_prev() end)
