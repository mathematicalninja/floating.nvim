---@type POSITION
local function clock()
    ---@type config_and_position
    local R = {}

    local row = vim.o.lines
    local col = vim.o.columns - 5

    R.pos = "clock_br"
    R.name_location = "footer"
    R.config = {
        width = 5,
        height = 1,
        col = col,
        row = row,
        title = "",
        title_pos = "center",
        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = { "╔", "═", "", "", "", "", "", "║" },
    }

    return R
end

return clock
