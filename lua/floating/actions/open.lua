---@alias ACTIONS.open fun(
---     FLOAT:FLOAT,
---     opts: {
---         style_name:style_name,
---         pos:position_abrv,
---         is_not_scratch:boolean | nil,
---         buf: integer | nil,
---     }
--- ):nil

-- Opens a particular style in a particular position.
---@type ACTIONS.open
local function Open(FLOAT, opts)
    local style_name = opts.style_name or "default"
    local position = opts.pos or "tr"

    local new_scratch_buffer = FLOAT.actions.new_scratch_buffer
    local ensure_buffer = FLOAT.actions.ensure_buffer
    local STYLE = FLOAT.style_tables[style_name]
    local dont_focus = STYLE.dont_focus

    -- get the STATE
    local STATE = FLOAT.state

    -- runs the style's "setup", e.g. get's current settings before opening the window
    STYLE.setup(STATE)

    local DATA = STATE.style_data[style_name]

    local is_not_scratch = opts.is_not_scratch or STYLE.is_not_scratch

    local buf = opts.buf
    if buf == nil then
        -- defaults to scratch, when is_not_scratch == nil.
        if is_not_scratch then
            buf = ensure_buffer()
        else
            buf = new_scratch_buffer()
        end
    else
        buf = ensure_buffer(buf)
    end

    -- draws the window.
    local FD = FLOAT.draw({
        position = position,
        buf = buf,
        dont_focus = dont_focus,
    })
    local bufwin = FD.bufwin
    local conf_pos = FD.draw_opts

    -- styles the window
    STYLE.style( --
        {
            state = STATE,
            bufwin = bufwin,
            conf_pos = conf_pos,
            data = DATA,
        }
    )

    -- styles handle their own state, and pass to the STATE object to handle which windows are open.
    STYLE.push(STATE, { buf = bufwin.buf, win = bufwin.win, position = position })
    STATE:push_win({ buf = bufwin.buf, win = bufwin.win, position = position, style_name = style_name })
    return conf_pos
end

return Open
