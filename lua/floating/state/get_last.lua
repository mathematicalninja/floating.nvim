--- @param STATE STATE
--- @return bufwin_state | nil
local Get_Last_Index = function(STATE)
    local wins = STATE.window_states

    local m = STATE:get_last_index()
    return wins[m]
end

return Get_Last_Index
