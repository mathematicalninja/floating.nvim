--- @alias window_id integer
--- @alias buffer_id integer

--- @class STATE
--- @field toggle fun(FLOAT:FLOAT, style_name:style_name)
--- @field window_states bufwin_state[]
--- @field buffer_ids buffer_id[]
--- @field style_data STATE.style_data
--- @field fill fun(STATE:STATE, bufwin_pos:bufwin_pos)
--- @field empty fun(STATE:STATE, bufwin_pos:bufwin_pos)
--- @field check fun(STATE:STATE, position_abrv)
--- @field get_last_win (fun(STATE:STATE):bufwin_state | nil)
--- @field get_last_index (fun(STATE:STATE):integer | nil)
--- @field close_last (fun(FLOAT:FLOAT):boolean | nil)
--- @field push_win fun(STATE:STATE, bufwin_state:bufwin_state):boolean
--- @field get_first_free_position fun(STATE:STATE, position_list:position_abrv[]):position_abrv

--- This is left blank so individual styles can add in their own data structure for personal consumption.
--- @class STATE.style_data

--- @type STATE
local STATE = {
    window_states = {},
    buffer_ids = {},
    style_data = {},
    fill = require("floating.state.fill"),
    empty = require("floating.state.empty"),
    toggle = require("floating.state.toggle"),
    check = require("floating.state.check"),
    get_last_win = require("floating.state.get_last_win"),
    get_last_index = require("floating.state.get_last_index"),
    close_last = require("floating.state.close_last"),
    push = require("floating.state.push_win"),
    get_first_free_position = require("floating.state.get_first_free_position"),
    push_win = require("floating.state.push_win"),
}
--- TODO:
--- What's positions? Where is is stored, and how can a user extend it? Automatically?
--- for _, pos positions do
---     table.insert(STATE.positions, pos)
--- end

return STATE
