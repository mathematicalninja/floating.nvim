-- quick reload
vim.keymap.set( --
    "n",
    "<leader><leader>r",
    "<CMD>Lazy reload floating<CR>",
    {}
)
--{{{ debug commands, only for global dev mode.

if DEV_FLOATING then
    --Note that **no** stateful object is passed into these, it's just testing the *local* Actions object's functionality.
    local Actions = require("floating.actions")
    --- @type FLOAT
    -- local DEV_FLOAT = require("floating")

    -- vim.api.nvim_create_user_command( --
    --     "FloatAAA",
    --     function()
    --         DEV_FLOAT.open({ pos = "tr", style = "duplicate" })
    --     end,
    --     {}
    -- )

    vim.api.nvim_create_user_command( --
        "FloatScratchTR",
        function()
            Actions.open({ actions = Actions }, { pos = "tr", style = "scratch" })
        end,
        {}
    )
    vim.api.nvim_create_user_command( --
        "FloatDuplicateTR",
        function()
            Actions.open({ actions = Actions }, { pos = "tr", style = "duplicate" })
        end,
        {}
    )
    vim.api.nvim_create_user_command( --
        "FloatDefaultTR",
        function()
            Actions.open({ actions = Actions }, { pos = "tr", style = "default" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatTR",
        function()
            Actions.open({ actions = Actions }, { pos = "tr" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatTL",
        function()
            Actions.open({ actions = Actions }, { pos = "tl" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatBR",
        function()
            Actions.open({ actions = Actions }, { pos = "br" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatBL",
        function()
            Actions.open({ actions = Actions }, { pos = "bl" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatTB",
        function()
            Actions.open({ actions = Actions }, { pos = "tb" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatBB",
        function()
            Actions.open({ actions = Actions }, { pos = "bb" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatPU",
        function()
            Actions.open({ actions = Actions }, { pos = "cp" })
        end,
        {}
    )

    vim.api.nvim_create_user_command( --
        "FloatALL",
        function()
            Actions.open({ actions = Actions }, { pos = "tr" })
            Actions.open({ actions = Actions }, { pos = "tl" })
            Actions.open({ actions = Actions }, { pos = "br" })
            Actions.open({ actions = Actions }, { pos = "bl" })
            -- Actions.open({ actions = Actions }, { pos = "tb" })
            -- Actions.open({ actions = Actions }, { pos = "bb" })
            -- Actions.open({ actions = Actions }, { pos = "cp" })
        end,
        {}
    )
end
--}}}
