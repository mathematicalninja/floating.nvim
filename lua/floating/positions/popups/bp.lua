---@type POSITION
local function F_bp()
    ---@type config_and_position
    local R = {}

    ---@type position_abrv
    R.pos = "bp"

    ---@type "footer" | "title"
    R.name_location = "title"

    local col = math.floor(vim.o.columns * 0.275)

    local width = math.floor(vim.o.columns * 0.45)
    local height = 1

    ---@type vim.api.keyset.win_config
    R.config = {
        width = width,
        height = height,

        col = col,
        row = vim.o.lines - 1,

        title = "",
        title_pos = "center",

        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = "rounded",
    }

    return R
end
return F_bp
