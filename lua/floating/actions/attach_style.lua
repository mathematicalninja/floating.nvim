--- adds the style to the Float's style names, and call's the style's ATTACH function
--- @param FLOAT FLOAT
--- @param STYLE STYLE
local function attach_style(FLOAT, STYLE)
    if STYLE == nil then
        return
    end
    if STYLE.name == nil then
        return
    end

    -- Allows the end consumer to skip definitions.
    local DEFAULT = require("floating.styles.default")
    local merged_table = vim.tbl_deep_extend("force", DEFAULT, STYLE)

    FLOAT.style_tables[STYLE.name] = merged_table
    STYLE.ATTACH(FLOAT)
end

return attach_style
