--- @param FLOAT FLOAT
--- @return boolean | nil
local Close_Last = function(FLOAT)
    local STATE = FLOAT.state
    local maxN = STATE:get_last_index()
    -- dereference for garbage collection.
    if maxN == nil then
        return nil
    end
    -- TODO: pass last into STATE.styles[last.style_name].pop()
    -- Somehow...
    local bufwin_state = STATE.window_states[maxN]
    local style = bufwin_state.style_name

    FLOAT.style_tables[style].pop(STATE, bufwin_state)

    STATE.window_states[maxN] = nil

    return true
end

return Close_Last
