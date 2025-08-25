--{{{ type definitions

--{{{ atomics

--- @alias style 'terminal'| 'scratch'| 'command'| 'duplicate'
--- @alias corner_abrv 'tr'| 'br'| 'tl'| 'bl'
--- @alias visibility 'focused'| 'closed' | 'unfocused'

--- @alias bufwin {buf:integer, win:integer}
--- @alias is_top_right {top:boolean, right:boolean}
--- @alias row_col {row:integer, col:integer}
--- @alias width_height {width:integer, height:integer}

-- }}}

-- {{{ composites
--- @alias filled table<corner_abrv, boolean>

--- @alias positionList filled[]
--- @alias windowList bufwin[]

--- @alias state_buffers table<style, bufwin>
--}}}

-- {{{ classes
--- @class state_position
--- @field filled filled
--- @field windowList windowList
--- @field positionList positionList

--- @class floatOpts
--- @field style style
--- @field is_top_right? is_top_right
--- @field bufwin? bufwin
--- @field title? string

--- @class toggleOpts
--- @field bufwin bufwin
--- @field is_top_right? is_top_right
--- @field style style
--- @field title? string

--- @class win_pos
--- @field row_col row_col
--- @field width_height width_height

--- @class win_got
--- @field bufwin bufwin
--- @field visibility visibility

---@class style_opts
---@field style style
---@field bufwin bufwin
---@field current_filetype string
---@field cur_buf integer
--}}}
--}}}
