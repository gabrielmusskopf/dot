local M = {}

--- Configura as propriedades de highlight de um grupo de highlight no Neovim.
-- Essa função busca as configurações atuais do grupo de highlight, mescla com as novas
-- configurações fornecidas e aplica as configurações resultantes no Neovim.
--
-- @param name string: O nome do grupo de highlight a ser modificado (ex: "LineNr", "SignColumn", etc).
-- @param updates table: A tabela contendo as novas configurações de highlight.
-- Pode incluir valores como `bg`, `fg`, `bold`, `italic`, etc. Qualquer configuração
-- fornecida substituirá as configurações anteriores para o grupo de highlight.
--
-- @return void
function M.set_hl(name, updates)
    local settings = vim.api.nvim_get_hl(0, { name = name })
    for key, value in pairs(updates) do
        settings[key] = value
    end
    vim.api.nvim_set_hl(0, name, settings)
end

function M.colorize(color)
    -- color = color or "gruvbox"
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    vim.o.background = "dark"

    M.set_hl("Normal", { bg = "none" })
    M.set_hl("NormalFloat", { bg = "none" })
    M.set_hl("Whitespace", { fg = "#292d2f" })
    M.set_hl("LineNr", { bg = "none" })
    -- M.set_hl("SignColumn", { bg = "none" })
end

return M
