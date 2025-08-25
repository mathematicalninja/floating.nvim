local apply = {}
--{{{ style functions

--- @return bufwin
--- @param bufwin bufwin
--- @param current_filetype string
function apply.scratch(bufwin, current_filetype)
    local buf = bufwin.buf
    if vim.bo[buf].filetype ~= current_filetype then
        vim.bo[buf].filetype = current_filetype
    end
    return bufwin
end

--- @return bufwin
--- @param bufwin bufwin
function apply.terminal(bufwin)
    if vim.bo[bufwin.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
        vim.api.nvim_feedkeys("i", "n", false) -- move into "i" mode.
    end
    return bufwin
end

--- @return bufwin
--- @param bufwin bufwin
--- @param cur_buf integer
function apply.duplicate(bufwin, cur_buf)
    vim.api.nvim_win_set_buf(bufwin.win, cur_buf)
    return bufwin
end

--- @return bufwin
--- @param bufwin bufwin
function apply.testing(bufwin)
    return bufwin
end

--- @param Float Float
--- @param opts style_opts
--- @return bufwin
function apply.style(Float, opts)
    -- alias for clarity
    local bufwin = opts.bufwin
    local style = opts.style
    local current_filetype = opts.current_filetype
    local current_bufnum = opts.cur_buf

    table.insert(Float.state.position.windowList, Float.state.buffers[style])
    -- TODO: this needs to be removed when a window is closed, i.e. a vim event.
    -- BufWinLeave

    -- buffer is a scratch: match file-type.
    if style == "scratch" then
        return apply.scratch(bufwin, current_filetype)
    elseif style == "terminal" then
        return apply.terminal(bufwin)
    elseif style == "duplicate" then
        -- state.duplicate.buf = 0 gives the desired functionality
        -- so nothing is needed here.
        return apply.duplicate(bufwin, current_bufnum)
    elseif style == "testing" then
        return apply.testing(bufwin)
    end

    return bufwin
end
return apply
--}}}
