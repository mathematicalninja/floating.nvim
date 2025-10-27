--- @alias special_abrv
--- | 'clock'

--- @type ACTIONS.DRAW.FUNCTION
local function clock()
    --- @type Position_Return
    local R = {}

    R.pos = "clock"
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
        -- border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        border = { "", "", "", "║", "╝", "═", "", "" },
        -- border = { "", "", "", "🯎", "🯯", "═", "", "" },
    }

    return R
end

return clock
