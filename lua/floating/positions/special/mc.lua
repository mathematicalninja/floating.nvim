---@type POSITION
local function F_mc()
    ---@type config_and_position
    local R = {}

    ---@type position_abrv
    R.pos = "mc"

    ---@type "footer" | "title"
    R.name_location = "title"

    local col = math.floor(vim.o.columns * 0.375)
    local row = math.floor(vim.o.lines * 0.375)

    local width = math.floor(vim.o.columns * 0.25)
    local height = math.floor(vim.o.lines * 0.25)

    ---@type vim.api.keyset.win_config
    R.config = {
        width = width,
        height = height,

        col = col,
        row = row,

        title = "",
        title_pos = "center",

        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = "rounded",
    }

    return R
end
return F_mc
