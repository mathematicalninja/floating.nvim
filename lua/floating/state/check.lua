--- Checks if a position is empty
---@param STATE STATE
---@param position_abrv position_abrv
---@return boolean
local function Check(STATE, position_abrv)
    local wins = STATE.window_states

    for _, w in ipairs(wins) do
        if w.position == position_abrv then
            if vim.api.nvim_win_is_valid(w.win) then
                return false
            end
        end
    end
    return true
end

return Check
