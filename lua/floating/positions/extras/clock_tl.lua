---@type POSITION
local function clock()
    ---@type config_and_position
    local R = {}

    R.pos = "clock_tl"
    R.name_location = "footer"
    R.config = {
        width = 5,
        height = 1,
        col = 0,
        row = 0,
        title = "",
        title_pos = "center",
        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = { "", "", "", "║", "╝", "═", "", "" },
    }

    return R
end

return clock
