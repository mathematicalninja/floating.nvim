--- @type ACTIONS.DRAW.FUNCTION
local function F_cb()
    --- @type Position_Return
    local R = {}

    --- @type position_abrv
    R.pos = "cp"

    --- @type "footer" | "title"
    R.name_location = "title"

    local col = math.floor(vim.o.columns * 0.275)
    local row = math.floor(vim.o.lines * 0.5)

    local width = math.floor(vim.o.columns * 0.45)
    local height = 1

    --- @type vim.api.keyset.win_config
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
return F_cb
