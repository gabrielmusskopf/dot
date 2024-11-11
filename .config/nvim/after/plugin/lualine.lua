local status, lualine = pcall(require, 'lualine')
if not status then
    return
end

local ayu_mirage = require('lualine.themes.ayu_mirage')
ayu_mirage.normal.b.bg = 'none'
ayu_mirage.normal.c.bg = 'none'
ayu_mirage.insert.b.bg = 'none'
ayu_mirage.visual.b.bg = 'none'

lualine.setup {
    options = {
        theme = ayu_mirage,
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
    }
}
