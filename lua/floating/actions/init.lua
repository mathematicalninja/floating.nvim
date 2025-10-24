--- @class ACTIONS
--- @field buffer ACTIONS.BUFFER
--- @field draw ACTIONS.DRAW
--- @field open ACTIONS.OPEN

--- @type ACTIONS
local Actions = {
    buffer = require("floating.actions.buffer"),
    draw = require("floating.actions.draw"),
    open = require("floating.actions.open"),
}

return Actions
