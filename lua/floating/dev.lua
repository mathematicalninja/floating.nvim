local dev_mode_on = function(FLOAT)
    -- quick reload
    vim.keymap.set( --
        "n",
        "<leader><leader>r",
        "<CMD>Lazy reload floating<CR>",
        {}
    )
    vim.api.nvim_create_user_command( --
        "FloatAAA",
        function()
            FLOAT.toggle("clock_tl")
        end,
        { desc = "pop a clock" }
    )

    vim.keymap.set( --
        "n",
        "<leader><leader>k",
        function()
            FLOAT.toggle("clock_tl")
        end,
        { desc = "pop a clock" }
    )
end

return dev_mode_on
