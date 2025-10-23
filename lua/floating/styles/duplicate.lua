--- @alias style_name
--- | style_name
--- | "duplicate"

-- adds type support for this style's data.
--- @class STATE.style_data
--- @field duplicate? {
---     old_buf:integer,
---     bufwins : bufwin_pos[],
--- }

--- @type STYLE
local Duplicate = {
    name = "duplicate",
    positions = { "tr", "br", "tl", "bl" },

    --- Adds the necessary fields to the STATE.styles[name].
    ATTACH = function(FLOAT)
        FLOAT.state.style_data["duplicate"] = { old_buf = -1, bufwins = {} }
    end,

    setup = function(STATE)
        -- Save's current buf for duplication *before* creating & moving into new buffer.
        STATE.style_data["duplicate"].old_buf = vim.api.nvim_get_current_buf()
    end,

    style = function(opts)
        local win = opts.bufwin.win
        local old_buf = opts.data.old_buf

        vim.api.nvim_win_set_buf(win, old_buf)
        -- Do no styling
        --[[
            This is where *styling* code would go. 
        --]]
    end,

    -- Adds a window to the state object
    push = function(STATE, bufwin_pos)
        if bufwin_pos == nil then
            return
        end

        -- save the bufwin for *STATE* to manage.
        STATE:fill(bufwin_pos)

        -- save the bufwin for *duplicate* to manage.
        table.insert(STATE.style_data.duplicate.bufwins, bufwin_pos)
    end,

    pop = function(STATE, bufwin_pos)
        if bufwin_pos == nil then
            return
        end
        STATE:empty(bufwin_pos)

        --- TODO: find bufwin_pos in table, remove it
        --- where table =
        --- STATE.style_data.duplicate.bufwins
    end,
}
return Duplicate
