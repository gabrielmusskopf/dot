local ok, obsidian = pcall(require, "obsidian")
if not ok then
    return
end

vim.api.nvim_set_keymap("n", "<leader>ob", ':ObsidianBacklinks<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>of", ':ObsidianFollowLink<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>on", ':ObsidianNew ', {})
vim.api.nvim_set_keymap("n", "<leader>ot", ':ObsidianTemplate<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>oo", ':ObsidianToday<CR>', {})
vim.api.nvim_set_keymap("n", "<leader>oe", ':ObsidianYesterday<CR>', {})

-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "ObsidianTodo" })

local notesPath = "~/notes"
local imageFolder = "Files"

local function save_clipboard_image()
    local filename = "Pasted image " .. os.date("%Y%m%d%H%M%S") .. ".png"
    local encoded_filename = filename:gsub(" ", "%%20")
    local escaped_filename = filename:gsub(" ", "\\ ")

    local full_path = notesPath .. "/" .. imageFolder .. "/" .. escaped_filename
    local exit_code = os.execute("xclip -selection clipboard -t image/png -o > " .. full_path .. " 2>&1")

    if exit_code == 0 then
        print("Imagem salva em: " .. full_path)
        local markdown_reference = "![" .. filename .. "](../Files/" .. encoded_filename .. ")"
        vim.api.nvim_put({ markdown_reference }, "c", true, true)

        return markdown_reference
    else
        print("Erro ao salvar a imagem. O conteúdo copiado é uma imagem?")
        return nil
    end
end

local function generate_pdf(path, destination)
end

local function export_file_pdf(file_path, destination)
    local escaped_path = file_path:gsub(" ", "\\ ")
    local escaped_destination = destination:gsub(" ", "\\ ")

    local exit_code = os.execute("pandoc " .. escaped_path .. " -o " .. destination ..
        " --pdf-engine=xelatex  -V geometry:a4paper -V geometry:margin=1in --resource-path=" ..
        imageFolder)

    if exit_code == 0 then
        os.execute("xdg-open " .. escaped_destination)
    else
        print("Erro ao gerar o PDF em " .. escaped_destination)
    end
end

local function export_to_pdf()
    local file_path = vim.api.nvim_buf_get_name(0)
    if file_path == "" then
        print("Erro: Nenhum arquivo aberto.")
        return
    end

    local destination = vim.fn.input("Destino do PDF: ", file_path:gsub("%.%w+$", ".pdf"), "file")
    vim.cmd("echo ''") -- Não sobreescrever lualine

    if destination == "" then
        -- TODO: Retornar quando for o mesmo arquivo
        return
    end

    local dir = destination:match("(.*/)") or "./"
    local check_dir = os.execute("test -d " .. dir)
    if check_dir ~= 0 then
        print("Erro: O diretório de destino não existe.")
        return
    end

    print("Gerando PDF...")
    return export_file_pdf(file_path, destination)
end

local function view_as_pdf()
    local file_path = vim.api.nvim_buf_get_name(0)
    if file_path == "" then
        print("Erro: Nenhum arquivo aberto.")
        return
    end

    local destination = "/tmp/nvim_viewer.pdf"
    return export_file_pdf(file_path, destination)
end

vim.keymap.set('n', '<leader>op', save_clipboard_image)
vim.keymap.set('n', '<leader>oe', export_to_pdf)
vim.keymap.set('n', '<leader>ov', view_as_pdf)

obsidian.setup({
    workspaces = {
        {
            name = "notes",
            path = notesPath,
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
        img_folder = imageFolder
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
