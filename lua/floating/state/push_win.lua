---adds the bufwin to the STATE object.
---@param STATE STATE
---@param bufwin_state bufwin_state
local Push = function(STATE, bufwin_state)
    table.insert(STATE.window_states, bufwin_state)
end

return Push
