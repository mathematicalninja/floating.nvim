---@alias ACTIONS {
---     close:ACTIONS.close,
---     close_last:ACTIONS.close_last,
---     draw:ACTIONS.draw,
---     ensure_buffer:ACTIONS.ensure_buffer,
---     hide:ACTIONS.hide,
---     hide_last:ACTIONS.hide_last
---     new_scratch_buffer:ACTIONS.new_scratch_buffer,
---     open:ACTIONS.open,
---}

---@type ACTIONS
local Actions = {
    close = require("floating.actions.close"),
    close_last = require("floating.actions.close_last"),
    draw = require("floating.actions.draw"),
    ensure_buffer = require("floating.actions.ensure_buffer"),
    hide = require("floating.actions.hide"),
    hide_last = require("floating.actions.hide_last"),
    new_scratch_buffer = require("floating.actions.new_scratch_buffer"),
    open = require("floating.actions.open"),
}

return Actions
