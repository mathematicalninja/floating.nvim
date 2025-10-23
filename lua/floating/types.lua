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
--- @field open fun(opts: Actions.Open.opts)
--- @field attach_style fun(STYLE:STYLE)
--- @field toggle fun(style_name:style_name)

--- @alias config_and_position {
---     config:vim.api.keyset.win_config,
---     pos:position_abrv,
---     name_location: "footer"|"title",
--- }
