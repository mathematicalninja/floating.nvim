--- @class ACTIONS.BUFFER
--- @field new_scratch (fun():integer)

--- @type (fun():integer)
local function New_Scratch()
    return vim.api.nvim_create_buf(false, true)
end

return New_Scratch
