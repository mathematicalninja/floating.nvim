--- @class ACTIONS.BUFFER
--- @field ensure (fun(buf:integer | nil):integer)

--- Ensures that `buf` is a non-nil, valid integer.
--- @type (fun(buf:integer | nil):integer)
local function Ensure(buf)
    if buf ~= nil and vim.api.nvim_buf_is_valid(buf) then
        return buf
    end

    -- *not* a Scratch
    return vim.api.nvim_create_buf(false, false)
end

return Ensure
