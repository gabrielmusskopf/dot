vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- slit panes movement
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<CR><C-l><CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<C-l>", "<C-W>l", { desc = "Move to left pane" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { desc = "Move to right pane" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { desc = "Move to up pane" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { desc = "Move to down pane" })

-- jump
vim.keymap.set("n", "<C-n>", "<C-d>zz", { desc = "Jump page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump page up" })

-- next greatest remap ever :
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank/copy to clipboard" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "LSP format file" })

-- :cclose to close quickfix list
vim.keymap.set("n", "]c", "<cmd>cnext<CR>", { desc = "Next on quickfix list" })
vim.keymap.set("n", "[c", "<cmd>cprev<CR>", { desc = "Previous on quickfix list" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "Replace word" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make the current file executable" })
vim.keymap.set({ "n", "v" }, "<leader>jq", "!!jq .<CR>", { silent = true, desc = "Format JSON with jq" })
vim.keymap.set('n', '<leader><leader>', '<C-^>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 40 })
    end,
})

vim.api.nvim_create_autocmd("BufWrite", {
    desc = 'Format file before saving',
    group = vim.api.nvim_create_augroup('FormatBeforeSave', { clear = true }),
    callback = function()
        vim.lsp.buf.format()
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = 'Store directory where vim started. Is is used to fuzzy find files',
    group = vim.api.nvim_create_augroup('SaveFirstPath', { clear = true }),
    callback = function()
        vim.g.first_path = vim.fn.expand('%:p:h') .. '/'
    end
})
