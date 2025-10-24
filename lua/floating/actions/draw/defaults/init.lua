--- @alias Position_Return {
---     pos: position_abrv,
---     name_location:"footer" | "title",
---     config:vim.api.keyset.win_config,
--- }
--- @alias ACTIONS.DRAW.FUNCTION fun():Position_Return
--{{{ Abbreviations

--- @alias position_abrv
--- | corner_abrv
--- | exotic_abrv
--- | special_abrv

--- @alias corner_abrv
--- | 'tr'  # Top Right
--- | 'tl'  # Top Left
--- | 'br'  # Bottom Right
--- | 'bl'  # Bottom Left

--- @alias exotic_abrv
--- | 'tp'  # Top Pop-up -- small pop-up
--- | 'tb'  # Top Bar -- full bar across top
--- | 'bp'  # Bottom Pop-up -- small pop-up
--- | 'bb'  # Bottom Bar -- full bar across bottom
--- | 'cp'  # Center Pop-up -- small pop-up

--- @alias special_abrv
--- | 'cc'
--}}}

--- @type {[position_abrv]:ACTIONS.DRAW.FUNCTION}
local Positions = {
    tr = require("floating.actions.draw.defaults.corners.tr"),
    br = require("floating.actions.draw.defaults.corners.br"),
    bl = require("floating.actions.draw.defaults.corners.bl"),
    tl = require("floating.actions.draw.defaults.corners.tl"),

    bb = require("floating.actions.draw.defaults.bars.bb"),
    tb = require("floating.actions.draw.defaults.bars.tb"),
    cp = require("floating.actions.draw.defaults.bars.cb"),

    cc = require("floating.actions.draw.defaults.special.cc"),
    clock = require("floating.actions.draw.defaults.special.cc"),
}

return Positions
