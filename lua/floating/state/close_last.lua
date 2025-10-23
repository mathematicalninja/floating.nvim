--- @param STATE STATE
local Close_Last = function(STATE)
    local maxN = STATE:get_last_index()
    -- dereference for garbage collection.
    if maxN == nil then
        return nil
    end
    -- TODO: pass last into STATE.styles[last.style_name].pop()
    -- Somehow...
    local last = STATE:get_last()
    STATE.window_states[maxN] = nil

    return true
end

return Close_Last
