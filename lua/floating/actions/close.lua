-- bufwin state ==> Style name

---@alias ACTIONS.close fun(
---     FLOAT:FLOAT,
---     opts: {
---         bufwin_state:bufwin_state | nil,
---         pos:position_abrv | nil,
---         style_name:style_name | nil,
---     },
--- )

---@type ACTIONS.close
local function Close(FLOAT, opts)
    local STATE = FLOAT.state
    local open_windows = STATE.window_states

    -- Close based on state.
    if opts.bufwin_state ~= nil then
        local STYLE = FLOAT.style_tables[opts.bufwin_state.style_name]
        for i, W in ipairs(open_windows) do
            if W.win == opts.bufwin_state.win then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue_style
                end
                -- Let the style handle any cleanup
                STYLE.pop(STATE, W)
                -- close the open window
                vim.api.nvim_win_close(W.win, false)
                -- remove from state
                table.remove(STATE.window_states, i)
            end
            ::continue_style::
        end
    end

    -- closes if both style_name and position match.
    if opts.style_name ~= nil and opts.pos ~= nil then
        for _, W in ipairs(open_windows) do
            if W.style_name == opts.style_name and W.position == opts.pos then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue_both
                end
                vim.api.nvim_win_close(W.win, false)
            end
            ::continue_both::
        end
    end

    -- closes last opened for a style.
    if opts.style_name ~= nil then
        -- local STYLE = FLOAT.style_tables[opts.style_name]
        -- FLOAT.actions.close_last(FLOAT, STYLE)
        FLOAT.actions.close_last(FLOAT, FLOAT.style_tables[opts.style_name].positions)
    end

    -- Close based on position.
    if opts.pos ~= nil then
        for i, W in ipairs(open_windows) do
            if W.position == opts.pos then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue_position
                end

                -- gets the style of the window.
                local STYLE = FLOAT.style_tables[W.style_name]
                -- Let the style handle any cleanup
                STYLE.pop(STATE, W)
                -- close the open window
                vim.api.nvim_win_close(W.win, false)
                -- remove from state
                table.remove(STATE.window_states, i)
            end
            ::continue_position::
        end
        return
    end
end

return Close
