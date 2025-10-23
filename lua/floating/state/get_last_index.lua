--- @param STATE STATE
--- @return integer | nil
local Get_Last_Index = function(STATE)
    local wins = STATE.window_states

    if wins[1] == nil then
        return nil
    end
    return table.maxn(wins)
end

return Get_Last_Index
