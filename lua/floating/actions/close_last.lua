---@alias ACTIONS.close_last fun(
---     FLOAT:FLOAT,
---     opts: {
---         position_list:position_abrv[] | nil,
---         style:STYLE | nil,
---     },
--- ):boolean | nil

---@type ACTIONS.close_last
local function close_last(FLOAT, opts)
    -- setup
    local STATE = FLOAT.state
    local maxN = STATE:get_last_index()
    if maxN == nil then
        return nil
    end

    -- no parameters: close most recently opened win, of any style
    if opts.position_list == nil and opts.style == nil then
        local last = STATE.get_last_win(STATE)
        if last == nil then
            return
        end
        FLOAT.actions.close(FLOAT, { bufwin_state = last })

        return true
    end

    local position_list = {}

    -- if style is defined, use it's position list as a default.
    if opts.style ~= nil then
        position_list = opts.style.positions
    end

    -- user can specify which positions to close.
    if opts.position_list ~= nil then
        -- note this is not nil, but my LSP is confused.
        ---@type position_abrv[]
        position_list = opts.position_list
    end

    if opts.style == nil and opts.position_list == nil then
        return
    end

    local pos_index = table.maxn(position_list)
    if pos_index == 0 then
        return false
    end

    while pos_index >= 1 do
        local pos = position_list[pos_index]
        local window_index = maxN

        while window_index >= 1 do
            local win = STATE.window_states[window_index]
            if opts.style ~= nil then
                if win.style_name ~= opts.style then
                    goto contiue_win
                end
            end
            if win.position == pos then
                FLOAT.actions.close(FLOAT, { bufwin_state = win })
                return true
            end
            ::contiue_win::
            window_index = window_index - 1
        end
        pos_index = pos_index - 1
    end
    return false
end
return close_last
