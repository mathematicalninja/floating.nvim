---@alias ACTIONS.hide fun(
---     FLOAT:FLOAT,
---     opts: {
---         bufwin_state:bufwin_state | nil,
---         pos:position_abrv | nil,
---         style_name:style_name | nil,
---     },
--- )

---@type ACTIONS.hide
local function Hide(FLOAT, opts)
    local STATE = FLOAT.state
    local open_windows = STATE.window_states

    -- hides the window based on state
    if opts.bufwin_state ~= nil then
        for _, W in ipairs(open_windows) do
            if W.win == opts.bufwin_state.win then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue
                end
                -- hides the open window
                vim.api.nvim_win_hide(W.win)
            end
            ::continue::
        end
    end

    -- hides if both style_name and position match.
    if opts.style_name ~= nil and opts.pos ~= nil then
        for _, W in ipairs(open_windows) do
            if W.style_name == opts.style_name and W.position == opts.pos then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue_both
                end
                vim.api.nvim_win_hide(W.win)
            end
            ::continue_both::
        end
    end

    -- hides last opened for a style.
    if opts.style_name ~= nil then
        -- local STYLE = FLOAT.style_tables[opts.style_name]
        -- FLOAT.actions.close_last(FLOAT, STYLE)
        FLOAT.actions.hide_last(FLOAT, FLOAT.style_tables[opts.style_name].positions)
    end
    -- hide based on position.
    if opts.pos ~= nil then
        for _, W in ipairs(open_windows) do
            if W.position == opts.pos then
                if not vim.api.nvim_win_is_valid(W.win) then
                    goto continue_position
                end
                -- hides the open window
                vim.api.nvim_win_hide(W.win)
            end
            ::continue_position::
        end
        return
    end
end

return Hide
