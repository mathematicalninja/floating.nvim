--- if no position is empty, returns the first preference.
--- @param STATE STATE
--- @param position_list position_abrv[]
local Get_First_Free_Position = function(STATE, position_list)
    for _, p in ipairs(position_list) do
        local free = STATE:check(p)
        if free then
            return p
        end
    end
    return position_list[table.maxn(position_list)]
end

return Get_First_Free_Position
