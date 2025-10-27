--- @type ACTIONS.DRAW.FUNCTION
local function F_tr()
    --- @type Position_Return
    local R = {}

    --- @type position_abrv
    R.pos = "tr"

    --- @type "footer" | "title"
    R.name_location = "footer"

    local width = math.floor(vim.o.columns * 0.45)
    local height = math.floor(vim.o.lines * 0.45)

    --- @type vim.api.keyset.win_config
    R.config = {
        width = width,
        height = height,

        col = vim.o.columns - width - 3,
        row = 1,

        footer = "",
        footer_pos = "left",

        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = "rounded",
    }

    return R
end

return F_tr
