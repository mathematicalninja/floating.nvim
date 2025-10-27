--- @alias style_name
--- | "clock"

-- adds type support for this style's data.
--- @class STATE.style_data
--- @field clock? {
---     time:string,
--- }
--- TODO read the docs on timers

--- @type style_name
local style_name = "clock"

--- @type STYLE
local Default = {
    name = style_name,
    positions = { "clock" },
    dont_enter = true,

    ATTACH = function(FLOAT)
        FLOAT.state.style_data.clock = {}
    end,

    setup = function(STATE)
        local time_offset = 8
        local time_table = os.date("*t", os.time() + time_offset * 3600)

        local M = tonumber(time_table.min)
        local H = tonumber(time_table.hour)

        local digits = {
            ["0"] = "🯰",
            ["1"] = "🯱",
            ["2"] = "🯲",
            ["3"] = "🯳",
            ["4"] = "🯴",
            ["5"] = "🯵",
            ["6"] = "🯶",
            ["7"] = "🯷",
            ["8"] = "🯸",
            ["9"] = "🯹",
        }

        local min = string.format("%02d", M)
        local min_array = {
            digits[string.sub(min, 1, 1)],
            digits[string.sub(min, 2, 2)],
        }

        local hour = string.format("%02d", H)
        local hour_array = {
            digits[string.sub(hour, 1, 1)],
            digits[string.sub(hour, 2, 2)],
        }

        local time = hour_array[1] .. hour_array[2] .. ":" .. min_array[1] .. min_array[2]
        -- local time = "🯸"

        STATE.style_data.clock = {
            time = time,
        }
    end,

    -- `style` is run after the new window is opened.
    style = function(opts)
        local buf = opts.bufwin.buf
        vim.api.nvim_buf_set_lines( --
            buf,
            0,
            -1,
            false,
            { opts.state.style_data.clock.time }
        )
    end,
}
return Default
