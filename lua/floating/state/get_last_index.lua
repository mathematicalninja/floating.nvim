---@param STATE STATE
---@return integer | nil
local Get_Last_Index = function(STATE)
    local wins = STATE.window_states

    if wins[1] == nil then
        return nil
    end
    local index = table.maxn(wins)

    while index > 1 do
        if vim.api.nvim_win_is_valid(wins[index].win) then
            return index
        end
        index = index - 1
    end
    return table.maxn(wins)
end

return Get_Last_Index
