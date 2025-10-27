--- @alias bufwin { buf:integer, win:integer }

--- @alias bufwin_pos {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
--- }

--- @alias bufwin_style {
---     buf:integer,
---     win:integer,
---     style_name:style_name,
--- }

--- @alias bufwin_state {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
---     style_name:style_name,
--- }

--- @class FLOAT
--- @field actions ACTIONS
--- @field state STATE
--- @field style_tables {[style_name]:STYLE}
--- @field draw ACTIONS.Draw
--- @field open fun(opts: Actions.Open.opts)
--- @field attach_style fun(STYLE:STYLE)
--- @field toggle fun(style_name:style_name)
--- @field positions {[position_abrv]:ACTIONS.DRAW.FUNCTION}

--- @alias config_and_position {
---     config:vim.api.keyset.win_config,
---     pos:position_abrv,
---     name_location: "footer"|"title",
--- }

--- @alias floatin_opts {
---     styles:STYLE[] | nil,
---     dev: boolean | nil,
---     dont_load_default_user_commands: boolean | nil,
---     dont_use_default_keymaps: boolean | nil,
--- }

--- @alias STYLE {
--- name: style_name,
--- positions: position_abrv[],
--- dont_enter: boolean | nil,
--- is_not_scratch: boolean | nil,
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
