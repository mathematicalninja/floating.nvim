--- @class Float_Get
--- @field current_filetype fun(): string
--- @field next_free_position fun(Float): is_top_right
--- @field win_config fun(win_pos,title): vim.api.keyset.win_config
local get = {}

function get.current_filetype()
    return vim.api.nvim_get_option_value("filetype", { buf = 0 })
end

-- IDEA: check what positions are filled, and position new window accordingly.
--- @param Float Float
--- @return is_top_right
function get.next_free_position(Float)
    local fill_order = { "tr", "br", "bl", "tl" }
    --- temp fixed location
    -- if true then
    -- return { top = true, right = true }
    -- end

    local count = #Float.state.position.windowList

    if count == 0 then
        return { top = true, right = true }
    end
    if count == 1 then
        return { top = false, right = true }
    end

    return { top = true, right = false }
end

--- @return vim.api.keyset.win_config
--- @param win_pos win_pos
--- @param title? string
function get.win_config(win_pos, title)
    -- Define window configuration
    --- @type vim.api.keyset.win_config
    local win_config = {
        width = win_pos.width_height.width,
        height = win_pos.width_height.height,
        col = win_pos.row_col.col,
        row = win_pos.row_col.row,

        title = title or "",

        style = "minimal", -- No borders or extra UI elements
        relative = "editor",
        border = "rounded",
        title_pos = "center",
    }
    return win_config
end

return get
