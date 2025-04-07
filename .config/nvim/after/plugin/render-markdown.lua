require('render-markdown').setup({
    log_level = 'debug',
    indent = {
        enabled = false,
        skip_heading = true,
    },
    bullet = {
        enabled = true,
        left_pad = 0,
        right_pad = 1,
        icons = { '•', '◦', '◦', '◦' },
    },
    heading = {
        sign = false,
        width = 'block',
        position = 'inline',
        -- icons = { '∽ ' },
        -- icons = { '∷ ' },
        -- icons = { '❀ ' },
        -- icons = { '✻ ' },
        icons = { '一 ', '二 ', '三 ', 'つ ', '五 ', '六 ' },
        -- icons = { '∫ ', '∬ ', '∭ ', '', '', '' },
        -- icons = { '', '~ ', '~ ', '~ ', '~ ', '~ ' },
        -- icons = { '• ', '•• ', '••• ', '•••• ', '••••• ', '•••••• ' },
        -- icons = { '— ', '—— ', '——— ', '———— ', '————— ', '—————— ' },
        -- icons = { '' },
        -- icons = { '󰎦 ', '󰎩 ', '󰎬 ', '󰎮 ', '󰎰 ', '󰎵 ' }
        -- icons = { '󰲠 ', '󰲢 ', '󰲤 ', '󰲦 ', '󰲨 ', '󰲪 ' },
        backgrounds = {
            -- 'Number',
            'Character',
        },
    },
    code = {
        -- width = 'block',
        -- min_width = 100,
        left_pad = 2,
        right_pad = 2,
        language_pad = 2,
        highlight = 'MsgSeparator',
    },
    latex = {
        enabled = false,
    },
    checkbox = {
        unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
            scope_highlight = nil,
        },
        checked = {
            scope_highlight = '@markup.strikethrough'
        },
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
            important = { raw = '[~]', rendered = '󰓎 ', highlight = 'DiagnosticWarn' },
        },
    },
})
