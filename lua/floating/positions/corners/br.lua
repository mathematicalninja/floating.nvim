--- @type ACTIONS.DRAW.FUNCTION
local function F_br()
    --- @type Position_Return
    local R = {}

    --- @type position_abrv
    R.pos = "br"

    --- @type "footer" | "title"
    R.name_location = "title"

    local width = math.floor(vim.o.columns * 0.45)
    local height = math.floor(vim.o.lines * 0.45) - 2

    --- @type vim.api.keyset.win_config
    R.config = {
        width = width,
        height = height,

        col = vim.o.columns - width - 3,
        row = vim.o.lines - height - 3,

        title = "",
        relative = "editor",
        style = "minimal", -- No extra UI elements, e.g. status bar.
        border = "rounded",
        title_pos = "left",
    }

    return R
end
return F_br
