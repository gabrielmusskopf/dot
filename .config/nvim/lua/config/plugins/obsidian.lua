local notesPath = "~/notes"
local imageFolder = "Files"

local function save_clipboard_image()
    local filename = "Pasted image " .. os.date("%Y%m%d%H%M%S") .. ".png"
    local encoded_filename = filename:gsub(" ", "%%20")
    local escaped_filename = filename:gsub(" ", "\\ ")

    local full_path = notesPath .. "/" .. imageFolder .. "/" .. escaped_filename
    local exit_code = os.execute("xclip -selection clipboard -t image/png -o > " .. full_path .. " 2>&1")

    if exit_code ~= 0 then
        vim.notify("Erro ao salvar a imagem. O conteúdo copiado é uma imagem?")
        return nil
    end
    vim.notify("Imagem salva em: " .. full_path)
    local markdown_reference = "![" .. filename .. "](../" .. imageFolder .. "/" .. encoded_filename .. ")"
    vim.api.nvim_put({ markdown_reference }, "c", true, true)
end

local function add_pandoc_unicode_math(tbl)
    -- https://github.com/marhop/pandoc-unicode-math
    local bin = 'pandoc-unicode-math'
    if vim.fn.executable(bin) == 1 then
        table.insert(tbl, '--filter')
        table.insert(tbl, bin)
    end
end

local function export_and_open_pdf(file_path, destination)
    local convert_command = {
        'pandoc', file_path,
        '-o', destination,
        '--pdf-engine', 'xelatex',
        '-V', 'geometry:a4paper',
        '-V', 'geometry:margin=1in',
        '-V', 'mathspec',
        '--resource-path', imageFolder,
    }
    add_pandoc_unicode_math(convert_command)

    local on_exit = function(response)
        vim.schedule(function()
            -- schedule para poder notificar
            if response.code ~= 0 then
                vim.notify(response.stderr, vim.log.levels.ERROR)
                return
            end
            local output = ""
            if response.stderr ~= nil and response.stderr ~= "" then
                output = "WARNING: " .. response.stderr .. "\n"
            end
            if response.stdout ~= nil and response.stdout ~= "" then
                output = output .. "INFO: " .. response.stdout
            end
            vim.notify(output)
            vim.system({ "xdg-open", destination })
        end)
    end

    vim.system(convert_command, on_exit)
end

local function export_to_pdf()
    local file_path = vim.fn.expand('%:p')
    local destination = vim.fn.input("Destino do PDF: ", file_path, "file")
    vim.cmd("echo ''")

    if destination == "" or destination == file_path then
        return
    end

    local dir = destination:match("(.*/)") or "./"
    if vim.fn.isdirectory(dir) == 0 then
        vim.notify('Destino não existe', vim.log.levels.ERROR)
        return
    end

    vim.notify('Gerando PDF...')
    export_and_open_pdf(file_path, destination)
    vim.notify('PDF gerado, abrindo visualização')
end

local function view_as_pdf()
    vim.notify('Iniciando visualização em PDF...')
    local file_path = vim.fn.expand('%:p')
    local destination = "/tmp/nvim_viewer.pdf"

    export_and_open_pdf(file_path, destination)
    vim.notify('Abrindo visualização')
end

return {
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        ft = { "markdown", "md" },
        cond = vim.fn.getcwd() == vim.fn.expand(notesPath),
        init = function()
            -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
            vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "ObsidianTodo" })
        end,
        keys = {
            { "<leader>ob", '<cmd>ObsidianBacklinks<CR>' },
            { "<leader>of", '<cmd>ObsidianFollowLink<CR>' },
            { "<leader>on", '<cmd>ObsidianNew ' },
            { "<leader>ot", '<cmd>ObsidianTemplate<CR>' },
            { "<leader>oo", '<cmd>ObsidianToday<CR>' },
            { "<leader>oe", '<cmd>ObsidianYesterday<CR>' },
            { '<leader>op', save_clipboard_image },
            { '<leader>oe', export_to_pdf },
            { '<leader>ov', view_as_pdf },
        },
        opts = {
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
        }
    },
}
