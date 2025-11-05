--- adds the style to the Float's style names, and call's the style's INIT function
---@param FLOAT FLOAT
---@param STYLE STYLE
local function attach_style(FLOAT, STYLE)
    if STYLE == nil then
        return
    end
    if STYLE.name == nil then
        return
    end

    -- Allows the end consumer to skip definitions.
    local DEFAULT = require("floating.styles.default")
    local merged_table = vim.tbl_extend("force", DEFAULT, STYLE)

    -- loads the mix of defaults and user defined into the FLOAT object.
    FLOAT.style_tables[STYLE.name] = merged_table

    -- default creates empty table for end user.
    FLOAT.state.style_data[STYLE.name] = {}

    -- Runs additional initialisation that the user needs.
    STYLE.INIT(FLOAT)
end

return attach_style
