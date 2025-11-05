---@type POSITION
local function F_bb()
    ---@type config_and_position
    local R = {}

    ---@type position_abrv
    R.pos = "bb"

    ---@type "footer" | "title"
    R.name_location = "title"

    local width = vim.o.columns
    local height = 1

    ---@type vim.api.keyset.win_config
    R.config = {
        width = width,
        height = height,

        col = 1,
        row = vim.o.lines - 1,

        title = "",
        title_pos = "center",

        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = "rounded",
    }

    return R
end
return F_bb
