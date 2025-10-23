--- @alias ACTIONS.DRAW (fun(
---   position:position_abrv,
---   buf:integer | nil,
--- ): {
---   bufwin:bufwin, -- {-1, -1} for a failed attempt.:
---   draw_opts:config_and_position,
--- })

--- TODO: change enter = true --> depends on style's settings.

--- @param opts config_and_position
--- --- @param buf integer | nil
--- @return bufwin
local function draw_default(opts, buf)
    local win = vim.api.nvim_open_win(buf or 0, true, opts.config)
    return { win = win, buf = buf or 0 }
end

--- @param position position_abrv
--- @param buf integer | nil
--- @return {bufwin:bufwin, draw_opts:config_and_position} {-1, -1} for a failed attempt.
local function Draw(position, buf)
    --- @type {[position_abrv]:ACTIONS.DRAW.FUNCTION}
    local positions = require("floating.actions.draw.defaults.init")
    for K, V in pairs(positions) do
        if K == position then
            local D = V()
            if D == nil then
                break
            end
            return { bufwin = draw_default(D, buf), draw_opts = D }
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
