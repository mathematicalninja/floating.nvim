local Toggle = {}
-- {{{ FloatScratch

--- @param Float Float
function Toggle.scratch(Float)
    Toggle.float(Float, { style = "scratch", bufwin = Float.state.buffers["scratch"] })
end

---}}
--{{{ FloatTesting

--- @param Float Float
function Toggle.testing(Float)
    print("testing")
end

vim.api.nvim_create_user_command( --
    "FloatTesting",
    Toggle.testing,
    {}
)

vim.keymap.set("n", "<leader><leader>t", "<CMD>FloatTesting<CR>", { desc = "floating [t]ests" })
--}}}
--{{{ FloatDuplicate

--- @param Float Float
function Toggle.duplicate(Float)
    Toggle({ style = "duplicate", bufwin = Float.state.buffers.duplicate })
end

vim.api.nvim_create_user_command( --
    "FloatDuplicate",
    Toggle.duplicate,
    {}
)

vim.keymap.set("n", "<leader><leader>d", "<CMD>FloatDuplicate<CR>", { desc = "floating [d]uplicate" })
--}}}
--{{{ FloatTerminal

--- @param Float Float
function Toggle.terminal(Float)
    Toggle({ style = "terminal", bufwin = Float.state.buffers.terminal })
end

vim.api.nvim_create_user_command( --
    "FloatTerminal",
    Toggle.terminal,
    {}
)

vim.keymap.set("n", "<leader><leader>r", "<CMD>FloatTerminal<CR>", { desc = "floating te[r]minal" })
--}}}
--{{{ FloatCommand

--- @param Float Float
function Toggle.command_line(Float)
    --[[TODO:
        check docs for command line,
        see if I can summon a cmd buffer
        make a "mini" version of floating window
        resize, reposition, experiment.
    --]]
    Toggle({ style = "command", bufwin = Float.state.buffers.terminal })
end

vim.api.nvim_create_user_command( --
    "FloatCommand",
    Toggle.command_line,
    {}
)

vim.keymap.set("n", "<leader><leader>c", "<CMD>FloatCommand<CR>", { desc = "floating [c]ommand" })
--- @param Float Float
--- @param opts toggleOpts
--- @return bufwin
function Toggle.float(Float, opts)
    -- TODO: on win open, add to filled. BufWinEnter
    -- TODO: add in "move" action.

    local gw = Float.check.win(opts.bufwin)
    local bufwin, visibility = gw.bufwin, gw.visibility
    local cur_buf = vim.api.nvim_get_current_buf()

    if visibility == "focused" then
        vim.api.nvim_win_close(bufwin.win, true)
        Float:pop_window()
    elseif visibility == "closed" then
        local current_filetype = Float.get.current_filetype()
        bufwin = Float.open_float({
            bufwin = bufwin,
            style = opts.style,
            title = opts.title,
            is_top_right = opts.is_top_right,
        })
        bufwin = Float.apply.style(Float, {
            style = opts.style,
            bufwin = bufwin,
            current_filetype = current_filetype,
            cur_buf = cur_buf,
        })
    elseif visibility == "unfocused" then
        vim.api.nvim_set_current_win(bufwin.win)
        return bufwin
    end

    return bufwin
end
return Toggle
-- }}}
