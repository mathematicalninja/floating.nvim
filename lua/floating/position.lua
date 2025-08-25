--{{{ position

--- @class Float_Position
local position = {}

--- @class position_window_opts
--- @field  bufwin bufwin,
--- @field is_top_right is_top_right,
--- @field  width_height width_height | nil,
--- @field row_col row_col | nil,

--- positions window based on {top =? true, right =? true}
--- @return bufwin
--- @param Float Float
--- @param opts position_window_opts
function position.window(Float, opts)
    --IDEA: get the window's current position (checking if it exists etc.) then position it according to input.
    --used to adjust a window

    local bufwin = opts.bufwin
    local is_top_right = opts.is_top_right
    -- optionals
    local width_height = opts.width_height or {}
    local row_col = opts.row_col or {}

    --- @type win_pos
    local new_pos
    if -- both are passed, and don't need to be calculated.
        (row_col ~= {}) and (width_height ~= {})
    then
        new_pos = { row_col = row_col, width_height = width_height }
    elseif -- use existing row_col
        row_col ~= {}
    then
        new_pos = Float.calculate.corners(is_top_right, width_height)
        new_pos.row_col = row_col
    elseif -- use existing width_height
        width_height ~= {}
    then
        new_pos = Float.calculate.corners(is_top_right, width_height)
        new_pos.width_height = width_height
    else -- fully calculate
        new_pos = Float.calculate.corners(is_top_right, width_height)
    end

    -- alias for clarity
    local width = new_pos.width_height.width
    local height = new_pos.width_height.height
    local col = new_pos.row_col.col
    local row = new_pos.row_col.row

    vim.api.nvim_win_set_width(bufwin.win, width)
    vim.api.nvim_win_set_height(bufwin.win, height)
    vim.api.nvim_win_set_config(bufwin.win, { col = col, row = row })
    return bufwin
end

--- @param Float Float
--- @param bufwin bufwin
--- @param width_height? width_height
function position.reposition_window(Float, bufwin, width_height)
    -- BUG: this should loop over all windows.

    local is_top_right = Float.get.next_free_position(Float)

    local win_pos = Float.calculate.corners(is_top_right)

    --- @type position_window_opts
    local opts = {
        is_top_right = is_top_right,
        row_col = win_pos.row_col,
        width_height = win_pos.width_height,
        bufwin = bufwin,
    }

    position.window(Float, opts)
end
return position
--}}}
