local ok, autosave = pcall(require, 'auto-save')
if not ok then
    print('Something went wrong with autosave:', autosave)
end

--print('sourcing autosave.lua')

autosave.setup({
    debounce_delay = 5000,
    execution_message = {
        cleaning_interval = 5000,
        message = function()
            return ("saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
    }
})
