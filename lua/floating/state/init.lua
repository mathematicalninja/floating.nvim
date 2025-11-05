---@alias STATE {
---     window_states:bufwin_state[],
---     style_data:STATE.style_data,
---     check:fun(
---         STATE:STATE,
---         position_abrv:position_abrv,
---     ),
---     get_last_win:(fun(
---         STATE:STATE,
---     ):bufwin_state | nil),
---     get_last_index:(fun(
---         STATE:STATE,
---     ):integer | nil),
---     get_first_free_position:(fun(
---         STATE:STATE,
---         position_list:position_abrv[],
---     ):position_abrv),
---     push_win:(fun(
---         STATE:STATE,
---         bufwin_state:bufwin_state,
---     ):boolean),
---     toggle:(fun(
---         FLOAT:FLOAT,
---         style_name:style_name,
---     )),
---     toggle_hide:(fun(
---         FLOAT:FLOAT,
---         style_name:style_name,
---     )),
--- }

---@type STATE
local STATE = {
    window_states = {},
    style_data = {},

    check = require("floating.state.check"),
    get_first_free_position = require("floating.state.get_first_free_position"),
    get_last_index = require("floating.state.get_last_index"),
    get_last_win = require("floating.state.get_last_win"),
    push_win = require("floating.state.push_win"),
    toggle = require("floating.state.toggle"),
    toggle_hide = require("floating.state.toggle_hide"),
}

return STATE
