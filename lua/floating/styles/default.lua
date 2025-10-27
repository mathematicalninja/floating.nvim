--- @alias style_name
--- | "default"

-- adds type support for this style's data.
--- @class STATE.style_data
--- @field default? {
--- }

--- @type style_name
local style_name = "default"

--- @type STYLE
local Default = {
    name = style_name,
    -- Corners
    positions = { "tr", "br", "tl", "bl" },
    -- "popup" bars
    -- positions = { "tb", "cb", "bb" },
    -- special cases
    -- positions = {
    --      "cc" -- center center
    --      "clock" -- mini clock pop-up in tl corner.
    -- },

    -- used for making buffers that are more permanent.
    is_not_scratch = false,

    -- `ATTACH` is run when the module is loaded by nvim.
    -- This is mainly to define a state buffer in FLOAT.STATE[this.name].
    ATTACH = function(FLOAT) end,

    -- `setup` runs before the new buffer or its window is opened. Useful for getting info about current buffer or what's under the cursor.
    setup = function(STATE) end,

    -- `style` is run after the new window is opened.
    style = function(opts) end,

    ----------------------------------------
    ----------------------------------------
    -- Largely speaking, the following can be left as is for most Floats.
    ----------------------------------------
    ----------------------------------------

    -- `pop` is called when a window is opened and needs to be *added* from FLOAT.STATE[this.name]
    push = function(STATE, bufwin_pos) end,

    -- `pop` is called when a window is closed and needs to be *removed* from FLOAT.STATE[this.name]
    pop = function(STATE, bufwin_pos) end,
}
return Default
