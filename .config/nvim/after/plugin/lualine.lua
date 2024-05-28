local status, lualine = pcall(require, 'lualine')
if not status then
    print('Something went wrong:', lualine)
end

lualine.setup {
    options = {
        theme = 'ayu_mirage',
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
    }
}
