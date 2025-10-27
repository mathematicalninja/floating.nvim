--- @alias ACTIONS.Draw (fun(
---   position:position_abrv,
---   buf:integer | nil,
---   dont_enter:boolean | nil,
--- ): {
---   bufwin:bufwin, -- {-1, -1} for a failed attempt.
---   draw_opts:config_and_position,
--- })

--- TODO: change enter = true --> depends on style's settings.

--- @param opts config_and_position
--- @param buf integer | nil
--- @param dont_enter boolean | nil
--- @return bufwin
local function draw_default(opts, buf, dont_enter)
    local enter = true
    if dont_enter then
        enter = false
    end
    local win = vim.api.nvim_open_win(buf or 0, enter, opts.config)
    return { win = win, buf = buf or 0 }
end

--- @return ACTIONS.Draw
--- @param positions {[position_abrv]:ACTIONS.DRAW.FUNCTION}
local function Draw_Setup(positions)
    --- @param position position_abrv
    --- @param buf integer | nil
    --- @param dont_enter boolean | nil
    --- @return {bufwin:bufwin, draw_opts:config_and_position} {-1, -1} for a failed attempt.
    local function Draw(position, buf, dont_enter)
        for K, V in pairs(positions) do
            if K == position then
                local D = V()
                if D == nil then
                    break
                end
                return { --
                    bufwin = draw_default(D, buf, dont_enter),
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
