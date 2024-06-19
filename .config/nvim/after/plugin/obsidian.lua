vim.api.nvim_set_keymap("n", "<leader>ob", ':ObsidianBacklinks<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>of", ':ObsidianFollowLink<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>on", ':ObsidianNew ', {})
vim.api.nvim_set_keymap("n", "<leader>ot", ':ObsidianTemplate<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>oo", ':ObsidianToday<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>oe", ':ObsidianYesterday<CR>', {})

-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "ObsidianTodo" })

require("obsidian").setup({
    workspaces = {
        {
            name = "notes",
            path = "~/notes",
        },
    },
    notes_subdir = "01-Main Notes",
    new_notes_location = "notes_subdir",
    templates = {
        folder = "Templates",
        date_format = "%d/%m/%Y",
        time_format = "%hh:%mm",
    },
    disable_frontmatter = true, -- metadata
    attachments = {
        img_folder = "Files"
    },
    daily_notes = {
        folder = "Daily",
        date_format = "%d/%m/%Y",
        template = "daily.md"
    },
    ui = {
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
            -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianImportant = { bold = true, fg = "#d73128" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
        },
    },
})
