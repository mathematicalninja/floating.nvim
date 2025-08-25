--- @class Float_State
--- @field bufwins state_buffers
--- @field state_buffers state_buffers
--- @field state_position state_position
local state = {}

-- {{{ State
--- @type state_buffers
state.buffers = {
    -- Set invalid window and buffer.
    terminal = { buf = -1, win = -1 },
    scratch = { buf = -1, win = -1 },
    command = { buf = -1, win = -1 },
    duplicate = { buf = 0, win = -1 }, -- 0 for current buf
}

--- @type  state_position
state.position = {
    filled = {
        tr = false,
        br = false,
        bl = false,
        tl = false,
    },

    windowList = {},
    positionList = {},
}

--- @param Float Float
--- @param style style
--- @param bufwin bufwin
--- @param _ any
function state.update(Float, style, bufwin, _)
    --TODO: update filled list
    --TODO: update window list
    --TODO: update position list
    Float.state.buffers[style] = bufwin
end
--- }}}
return state
