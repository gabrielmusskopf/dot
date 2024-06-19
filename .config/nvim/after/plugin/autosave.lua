local ok, autosave = pcall(require, 'auto-save')
if not ok then
    print('Something went wrong with autosave:', autosave)
end

--print('sourcing autosave.lua')

autosave.setup({
    debounce_delay = 15000,
    execution_message = {
        cleaning_interval = 15000,
        message = function()
            return ("saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
    }
})
