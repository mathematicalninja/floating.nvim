require("floating.types")

--- @class Float
local Float = {
    check = require("floating.check"),
    state = require("floating.state"),
    get = require("floating.get"),
    calculate = require("floating.calculate"),
    position = require("floating.position"),
    apply = require("floating.apply"),
    toggle = require("floating.toggle"),
}

--{{{ config and state

function Float:pop_window()
    table.remove(self.state.position.windowList, 1)
    -- if #state_position.windowList > 0 then
    -- reposition_windows()
    -- end
end

function Float.on_float_attach(bufwin)
    -- TODO: cleanup auto command for window close
    -- TODO: on win open, BufWinEnter
end
--}}}

--{{{ float functions

--- @param opts floatOpts
--- @return bufwin
function Float.open_float(opts)
    -- if valid, use existing buf, else make new one.
    local buf = Float.check.buf(opts.bufwin).buf

    -- TODO: exchange this to position_window
    -- move "positional logic" into apply_style, allowing different styles to micromanage.
    local width_height = Float.calculate.width_height()
    local is_top_right = Float.get.next_free_position(Float)
    local win_pos = Float.calculate.corners(is_top_right, width_height)
    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, Float.get.win_config(win_pos, opts.title))

    -- update and cleanup.
    Float.state.update(Float, opts.style, { buf = buf, win = win })

    return { buf = buf, win = win }
end

--}}}

vim.api.nvim_create_user_command( --
    "FloatScratch",
    function()
        Float.toggle.scratch(Float)
    end,
    {}
)

vim.keymap.set("n", "<leader><leader>f", "<CMD>FloatScratch<CR>", { desc = "[f]loating buffer" })
return Float
