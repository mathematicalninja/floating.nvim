---@type {[position_abrv]:POSITION}
local Positions = {
    -- Corners
    tr = require("floating.positions.corners.tr"),
    br = require("floating.positions.corners.br"),
    bl = require("floating.positions.corners.bl"),
    tl = require("floating.positions.corners.tl"),

    -- Full bars
    tb = require("floating.positions.bars.tb"),
    bb = require("floating.positions.bars.bb"),

    -- popups
    bp = require("floating.positions.popups.bp"),
    cp = require("floating.positions.popups.cb"),
    tp = require("floating.positions.popups.tp"),

    -- other
    mc = require("floating.positions.special.mc"),
}

return Positions
