---@alias ACTIONS.draw (fun(
---   position:position_abrv,
---   buf:integer | nil,
---   dont_focus:boolean | nil,
--- ): {
---   bufwin:bufwin, -- {-1, -1} for a failed attempt.
---   draw_opts:config_and_position,
--- })

--- TODO: change enter = true --> depends on style's settings.

---@param opts config_and_position
---@param buf integer | nil
---@param dont_focus boolean | nil
---@return bufwin
local function draw_default(opts, buf, dont_focus)
    local enter = true
    if dont_focus then
        enter = false
    end
    local win = vim.api.nvim_open_win(buf or 0, enter, opts.config)
    return { win = win, buf = buf or 0 }
end

---@alias FLOAT.draw (fun(
---     opts:{
---         position:position_abrv,
---         buf:integer | nil,
---         dont_focus:boolean | nil,
---     }):{
---         bufwin:bufwin, -- {-1, -1} for a failed attempt.
---         draw_opts:config_and_position
---     })

---@return ACTIONS.draw
---@param positions {[position_abrv]:POSITION}
local function Draw_Setup(positions)
    ---@type FLOAT.draw
    local function Draw(opts)
        local position = opts.position
        local buf = opts.buf
        local dont_focus = opts.dont_focus

        for K, V in pairs(positions) do
            if K == position then
                local D = V()
                if D == nil then
                    break
                end
                return { --
                    bufwin = draw_default(D, buf, dont_focus),
                    draw_opts = D,
                }
            end
        end

        return {
            bufwin = { win = -1, buf = -1 },
            draw_opts = {
                config = nil,
                pos = nil,
                name_location = nil,
            },
        }
    end

    return Draw
end

return Draw_Setup
