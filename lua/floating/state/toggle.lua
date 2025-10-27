--- If the style is already open, but unfocused, then it will be focused (and z-index updated if need be __TODO__)
--- If it is open and focused, it will be closed.
--- Otherwise a new window will be opened where it's best.
--- The idea is that the first (empty) position that the style *wants* to fill will be selected, or (if they are all full) the first one will be selected and just "cover" whatever's in it without closing that.
--- @param FLOAT FLOAT
---@param style_name style_name
local function Toggle(FLOAT, style_name)
    -- TODO: first need to loop over currently open windows to check if any of them are style_name, then if not, check for first_free_position

    local STYLE = FLOAT.style_tables[style_name]
    local STATE = FLOAT.state
    -- BUG ensure that
    -- positions != nil or {}

    -- Checks current windows. Focuses or closes open win.
    local wins = STATE.window_states
    for i, w in ipairs(wins) do
        if STYLE.name ~= w.style_name then
            goto next_window
        end

        -- if not a window, skip.
        if not vim.api.nvim_win_is_valid(w.win) then
            goto next_window
        end

        -- currently open window, close it. AND allow style to remove.
        if vim.api.nvim_get_current_win() == w.win then
            table.remove(STATE.window_states, i)
            STYLE.pop(STATE, w)
            vim.api.nvim_win_close(w.win, true)
            return
        end

        -- if the style should *never* be entered, then just close it.
        if STYLE.dont_enter then
            table.remove(STATE.window_states, i)
            STYLE.pop(STATE, w)
            vim.api.nvim_win_close(w.win, true)
            return
        end

        -- Valid buf, not current, so focus it.
        if true then
            vim.api.nvim_set_current_win(w.win)
            return
        end
        ::next_window::
    end

    -- ordered list of *preferred* positions.
    local positions = STYLE.positions
    local p = STATE:get_first_free_position(positions)
    FLOAT.open({
        style_name = STYLE.name,
        pos = p,
    })
end

return Toggle
