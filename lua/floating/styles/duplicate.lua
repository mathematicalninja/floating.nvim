---@alias style_name
--- | style_name
--- | "duplicate"

-- adds type support for this style's data.
---@class STATE.style_data
---@field duplicate? {
---     old_buf:integer,
---     bufwins : bufwin_pos[],
--- }

---@type STYLE
local Duplicate = {
    name = "duplicate",
    positions = { "tr", "br", "tl", "bl" },

    --- Adds the necessary fields to the STATE.styles[name].
    INIT = function(FLOAT)
        FLOAT.state.style_data["duplicate"] = { old_buf = nil, bufwins = {} }
    end,

    setup = function(STATE)
        -- Save's current buf for duplication *before* creating & moving into new buffer.
        STATE.style_data["duplicate"].old_buf = vim.api.nvim_get_current_buf()
    end,

    style = function(opts)
        local win = opts.bufwin.win
        local old_buf = opts.data.old_buf

        vim.api.nvim_win_set_buf(win, old_buf)
    end,

    -- Adds a window to the state object
    push = function(STATE, bufwin_pos)
        if bufwin_pos == nil then
            return
        end

        ---@type bufwin_state
        local bufwin_state = {
            buf = bufwin_pos.buf,
            win = bufwin_pos.win,
            position = bufwin_pos.position,
            style_name = "duplicate",
        }

        -- save the bufwin for *duplicate* to manage.
        table.insert(STATE.style_data.duplicate.bufwins, bufwin_pos)
    end,

    pop = function(STATE, bufwin_pos)
        if bufwin_pos == nil then
            return
        end

        for i, bw_p in ipairs(STATE.style_data.duplicate.bufwins) do
            if bw_p.win == bufwin_pos then
                table.remove(STATE.style_data.duplicate.bufwins, i)
            end
        end
    end,
}
return Duplicate
