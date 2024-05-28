local Goyo_enter = function()
    require("lualine").hide({
        place = { "statusline", "tabline", "winbar" },
        unhide = false,
        hide = true,
    })
end

local function Goyo_leave()
    require("lualine").hide({
        place = { "statusline", "tabline", "winbar" },
        unhide = true,
    })
end


local GoyoGroup = vim.api.nvim_create_augroup("GoyoGroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoEnter",
    callback = Goyo_enter,
    group = GoyoGroup,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GoyoLeave",
    callback = Goyo_leave,
    group = GoyoGroup,

})
