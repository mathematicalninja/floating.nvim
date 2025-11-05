local local_plugins = {

    {
        "floating",
        dir = "~/Code/nvim/floating",

        config = function()
            ---@alias style_name
            --- | "clock_tr"

            ---@alias special_abrv
            --- | "clock_tr"

            ---@type Setup_Opts
            local opts = {

                dev = true,
                positions = {
                    function()
                        ---@type config_and_position
                        local R = {}

                        R.pos = "clock_tr"
                        R.name_location = "footer"
                        R.config = {
                            width = 5,
                            height = 1,
                            col = vim.o.col - 5,
                            row = 0,
                            title = "",
                            title_pos = "center",
                            relative = "editor",
                            style = "minimal", -- No extra UI elements, e.g. status bar.
                            border = { "", "", "", "║", "╝", "═", "", "" },
                        }

                        return R
                    end,
                },
                styles = {
                    name = "clock_tr",
                    positions = { "clock_tr" },
                    dont_focus = true,

                    INIT = function(FLOAT)
                        FLOAT.state.style_data.clock = {}
                    end,

                    setup = function(STATE)
                        local time_offset = 0
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
                },
                dont_load_default_user_commands = false,
                dont_use_default_keymaps = false,
            }

            ---@type FLOAT
            local FLOAT = require("floating").setup(opts)

            print("HAHAHAHAH")
            vim.keymap.set( --
                "n",
                "<leader>fi",
                function()
                    print("tr")
                    FLOAT.toggle("clock_tr")
                end,
                {}
            )
        end,
    },
}
return local_plugins
