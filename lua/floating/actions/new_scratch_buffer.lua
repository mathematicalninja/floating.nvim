---@alias ACTIONS.new_scratch_buffer (fun():integer)

---@type ACTIONS.new_scratch_buffer
local function New_Scratch()
    return vim.api.nvim_create_buf(false, true)
end

return New_Scratch
