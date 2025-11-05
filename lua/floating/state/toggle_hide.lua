--- If the style is already open, but unfocused, then it will be focused (and z-index updated if need be __TODO__)
--- If it is open and focused, it will be hidden.
--- Otherwise a new window will be opened where it's best.
--- The idea is that the first (empty) position that the style *wants* to fill will be selected, or (if they are all full) the first one will be selected and just "cover" whatever's in it without closing that.
---@param FLOAT FLOAT
---@param style_name style_name
---@param pos position_abrv | nil
local function Toggle(FLOAT, style_name, pos)
    -- TODO: first need to loop over currently open windows to check if any of them are style_name, then if not, check for first_free_position

    local STYLE = FLOAT.style_tables[style_name]
    local STATE = FLOAT.state
    -- BUG ensure that
    -- positions != nil or {}

    -- Checks current windows. Focuses or hides open win.
    local wins = STATE.window_states
    for i, w in ipairs(wins) do
        if STYLE.name ~= w.style_name then
            goto next_window
        end

        -- if not a window, skip.
        if not vim.api.nvim_win_is_valid(w.win) then
            -- TODO: can use open({buf=buf}) to open a valid buffer in a closed window
            goto next_window
        end

        -- currently open window, hides it. AND allow style to remove.
        if vim.api.nvim_get_current_win() == w.win then
            table.remove(STATE.window_states, i)
            STYLE.pop(STATE, w)
            vim.api.nvim_win_hide(w.win)
            return
        end

        -- if the style should *never* be entered, then just hides it.
        if STYLE.dont_focus then
            table.remove(STATE.window_states, i)
            STYLE.pop(STATE, w)
            vim.api.nvim_win_hide(w.win)
            return
        end

        -- Valid buf, not current, so focus it.
        if true then
            vim.api.nvim_set_current_win(w.win)
            return
        end
        ::next_window::
    end

    ---@type position_abrv
    local p
    if pos ~= nil then
        p = pos
    else
        -- ordered list of *preferred* positions.
        local positions = STYLE.positions
        p = STATE:get_first_free_position(positions)
    end

    FLOAT.open({
        style_name = STYLE.name,
        pos = p,
        is_not_scratch = STYLE.is_not_scratch,
    })
end

return Toggle
