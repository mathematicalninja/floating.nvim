--{{{ Bufwin definitions

---@alias bufwin { buf:integer, win:integer }

---@alias bufwin_pos {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
--- }

---@alias bufwin_style {
---     buf:integer,
---     win:integer,
---     style_name:style_name,
--- }

---@alias bufwin_state {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
---     style_name:style_name,
--- }
--}}}

--{{{ FLOAT

---@alias FLOAT {
---     actions: ACTIONS,
---     state: STATE,
---     attach_style: fun(STYLE:STYLE),
---     style_tables: {[style_name]:STYLE},
---     positions: {[position_abrv]:POSITION},
---     draw: FLOAT.draw,
---     open: fun(
---         opts:{
---              style_name:style_name,
---              pos:position_abrv,
---              is_not_scratch:boolean | nil,
---              buf: integer | nil,
---         },
---     ),
---     close: fun(bufwin_state:bufwin_state),
---     hide: fun(bufwin_state:bufwin_state),
---     toggle: fun(style_name:style_name, pos: position_abrv | nil),
---     toggle_hide: fun(style_name:style_name, pos: position_abrv | nil),
--- }
--}}}

--{{{ STYLE

---@alias STYLE {
---     name: style_name,
---     positions: position_abrv[],
---     dont_focus: boolean | nil,
---     is_not_scratch: boolean | nil,
---     INIT: (fun(
---                 FLOAT:FLOAT,
---             ):nil) | nil,
---     setup: (fun(STATE:STATE)),
---     style: (fun(opts:{
---                 state:STATE,
---                 bufwin:bufwin,
---                 conf_pos:config_and_position,
---                 data:table, --- individual float styles define what their data looks like.
---             }):nil),
---     push: (fun(
---                 STATE:STATE,
---                 bufwin_pos:bufwin_pos,
---             ):nil),
---     pop: (fun(
---                 STATE:STATE,
---                 bufwin_state:bufwin_state,
---             ):nil),
--- }
--}}}

--{{{ Position (function) and return.

---@alias config_and_position {
---     config:vim.api.keyset.win_config,
---     pos:position_abrv,
---     name_location: "footer"|"title",
--- }

---@alias POSITION fun():config_and_position
--}}}

--{{{ Position Abbreviations

---@alias position_abrv
--- | corner_abrv
--- | popup_abrv
--- | bar_abrv
--- | special_abrv
--- | extra_positions

---@alias corner_abrv
--- | 'tr'  # Top Right
--- | 'tl'  # Top Left
--- | 'br'  # Bottom Right
--- | 'bl'  # Bottom Left

---@alias popup_abrv
--- | 'tp'  # Top Pop-up -- small pop-up
--- | 'cp'  # Center Pop-up -- small pop-up
--- | 'bp'  # Bottom Pop-up -- small pop-up
---
---@alias bar_abrv
--- | 'tb'  # Top Bar -- full bar across top
--- | 'bb'  # Bottom Bar -- full bar across bottom

---@alias special_abrv
--- | 'mc' # Center center -- a mini popup in the very center
--}}}

--{{{ Module return and options

---@alias Module_type {
---     setup: (fun(Setup_Opts:Setup_Opts):FLOAT),
--- }

---@alias Setup_Opts {
---     dev: boolean | nil,
---     dont_load_default_user_commands: boolean | nil,
---     dont_use_default_keymaps: boolean | nil,
---     styles:{[style_name]:STYLE},
---     positions: {[position_abrv]:POSITION},
---     extras: {
---         positions:extra_positions[],
---         styles:extra_styles[],
---     }
--- }
--}}}

--- This is left blank so individual styles can add in their own data structure for personal consumption.
---@class STATE.style_data

--{{{ Opt-in extras

---@alias extra_positions
--- | "clock_tl"
--- | "clock_tr"
--- | "clock_bl"
--- | "clock_br"

---@alias extra_styles
--- | "clock_tl"
--- | "clock_tr"
--- | "clock_bl"
--- | "clock_br"
--}}}
