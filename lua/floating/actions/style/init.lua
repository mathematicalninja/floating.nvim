-- TODO: migrate to FLOAT.STYLE
-- TODO: asyncronise setup, so calling open can happen after data setup without hanging nvim.

--- @alias STYLE {
--- name: style_name,
--- positions: position_abrv[],
--- ATTACH: (fun(
---             FLOAT:FLOAT,
---         ):nil),
--- setup: (fun(STATE:STATE)),
--- style: (fun(opts:{
---             state:STATE,
---             bufwin:bufwin,
---             conf_pos:config_and_position,
---             data:table, --- individual float styles define what their data looks like.
---         }):nil),
--- push: (fun(
---             STATE:STATE,
---             bufwin_pos:bufwin_pos,
---         ):nil),
--- pop: (fun(
---             STATE:STATE,
---             bufwin_state:bufwin_state,
---         ):nil),
--- }

--- @alias ACTIONS.STYLES {[style_name]: STYLE}

--- @alias style_name
--- | "default"

--- @type ACTIONS.STYLES
local Style = {
    -- The "do nothing" style. Simply opens a window in a corner.
    -- default = require("floating.actions.style.default"),

    -- duplicate = require("floating.actions.style.duplicate"),
    -- scratch = require("floating.actions.style.scratch"),
}

return Style
