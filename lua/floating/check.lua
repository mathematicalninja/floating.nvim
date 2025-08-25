--- @class Float_Check
--- @field buf fun(bufwin:bufwin): bufwin
--- @field win fun(bufwin:bufwin): win_got
local check = {}

--{{{ bufwin check

--- check if the buffer exists, or create it.
--- @param bufwin bufwin
--- @return bufwin
function check.buf(bufwin)
    if vim.api.nvim_buf_is_valid(bufwin.buf) then
        return bufwin
    else
        return {
            buf = vim.api.nvim_create_buf(false, true), -- unlisted, scratch buffer
            win = -1,
        }
    end
end

--- returns current state of window and it's bufwin
--- @param bufwin bufwin
--- @return win_got
function check.win(bufwin)
    if -- Window doesn't exist and needs to be opened,
        not vim.api.nvim_win_is_valid(bufwin.win)
    then
        return {
            bufwin = { win = -1, buf = bufwin.buf },
            visibility = "closed",
        }
    end

    if -- FOCUSED == true
        vim.api.nvim_get_current_win() == bufwin.win
    then -- already visible, hide it.
        return {
            bufwin = bufwin,
            visibility = "focused",
        }
    else
        return {
            bufwin = bufwin,
            visibility = "unfocused",
        }
    end
end

return check
--}}}
