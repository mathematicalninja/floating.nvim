--- usage: STATE:get_last() or
---
---  Float.get_last = function() return Float.state.get_last(Float.state) end
--- @param STATE STATE
local function Get_Last_Win(STATE)
    -- local index = STATE:get_last_index()
    -- local wins = STATE.window_states
    -- local last = wins[index]
    --
    -- return last

    return STATE.window_states[STATE.get_last_index(STATE)]
end

return Get_Last_Win
