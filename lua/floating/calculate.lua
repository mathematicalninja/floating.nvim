--{{{ calculate
--- @class Float_Calculate
--- @field width_height fun(width_height:width_height?): width_height
--- @field corners fun(is_top_right:is_top_right, width_height:width_height?): win_pos
local calculate = {}

--- @param width_height? width_height
--- @return width_height
function calculate.width_height(width_height)
    local win_pos = {}
    if width_height ~= nil then
        win_pos.width = width_height.width or math.floor(vim.o.columns * 0.45) - 1
        win_pos.height = width_height.height or math.floor(vim.o.lines * 0.45) - 1
    else
        win_pos.width = math.floor(vim.o.columns * 0.45) - 1
        win_pos.height = math.floor(vim.o.lines * 0.45) - 1
    end
    return win_pos
end

--- @param is_top_right is_top_right
--- @param width_height? width_height
--- @return win_pos
function calculate.corners(is_top_right, width_height)
    local top = is_top_right.top
    local right = is_top_right.right

    local lines = vim.o.lines
    local columns = vim.o.columns

    local win_pos = { -- return array
        width_height = calculate.width_height(width_height),
        row_col = {
            row = -1,
            col = -1,
        },
    }

    -- calculates the position of the top right corner of terminal
    -- `right`/`top` say which corner of the screen to occupy.
    if not right then
        win_pos.row_col.col = 2
    else
        win_pos.row_col.col = math.floor(columns - win_pos.width_height.width) - 2
    end
    if not top then
        win_pos.row_col.row = math.floor(lines - win_pos.width_height.height) - 2
    else
        win_pos.row_col.row = 1
    end
    return win_pos
end

return calculate
--}}}
