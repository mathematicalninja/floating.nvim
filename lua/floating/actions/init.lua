--- @class ACTIONS
--- @field buffer ACTIONS.BUFFER
--- @field draw POSITIONS.Draw
--- @field open ACTIONS.OPEN

--- @type ACTIONS
local Actions = {
    buffer = require("floating.actions.buffer"),
    close = require("floating.actions.close"),
    ensure_buffer = require("floating.actions.ensure_buffer"),
    new_scratch_buffer = require("floating.actions.new_scratch_buffer"),
    open = require("floating.actions.open"),

    draw = require("floating.positions.init"),
}

return Actions
