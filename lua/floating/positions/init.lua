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
    tr = require("floating.positions.corners.tr"),
    br = require("floating.positions.corners.br"),
    bl = require("floating.positions.corners.bl"),
    tl = require("floating.positions.corners.tl"),

    bb = require("floating.positions.bars.bb"),
    tb = require("floating.positions.bars.tb"),
    cp = require("floating.positions.bars.cb"),

    cc = require("floating.positions.special.cc"),
    clock = require("floating.positions.special.clock"),
}

return Positions
