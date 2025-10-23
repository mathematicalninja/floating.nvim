--- @type STYLE
local function Scratch()
    -- get calling buffer's file type
    local buf = vim.api.nvim_get_current_buf() -- in case of oddities. (rather than buf = 0)
    local ft = vim.bo[buf].filetype

    local function style(bufwin, winconfig)
        -- 1. Win config
        local conf = vim.api.nvim_win_get_config(bufwin.win)

        --- TODO: add in "nvim-web-devicons" as an (optional) dependency, and if-check it here.
        --[[
             local devicons = require("nvim-web-devicons")
             
             local function buffer_icon(bufnr)
               local name = vim.api.nvim_buf_get_name(bufnr)
               local ext  = vim.fn.fnamemodify(name, ":e")
             
               local icon, hl = devicons.get_icon(name, ext, { default = true })
               return icon, hl
             end
             
             -- Usage
             local icon, hl = buffer_icon(bufwin.buf)
             print(icon, hl)


        --]]

        -- set title (may be in the footer)
        conf[winconfig.name_location] = "Scratch." .. ft
        vim.api.nvim_win_set_config(bufwin.win, conf)

        -- 2. Set to scratch details.

        -- prevents accidental saving of a temp file.
        vim.api.nvim_buf_set_var(bufwin.buf, "write", false)
        -- ignores vim modelines (there shouldn't be one in a scratch buffer, so this is probably over-kill.
        vim.api.nvim_buf_set_var(bufwin.buf, "modeline", false)
        -- hides buffer from buffer list
        vim.api.nvim_buf_set_var(bufwin.buf, "buflisted", false)
        --

        -- 3. File-type match
        vim.bo[bufwin.buf].filetype = ft
    end

    return style
end

return Scratch
