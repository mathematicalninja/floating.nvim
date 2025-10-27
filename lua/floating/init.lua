-- duplicate loading prevention
-- note "floating.nvim" is a reasonably likely name conflict.
-- if vim.g.loaded_mathematicalninja_floating_nvim then
--     return
-- end
-- vim.g.loaded_mathematicalninja_floating_nvim = true

local M = {}
M.setup = function(setup_opts)
    -- developer mode, should be off, unless you want to fiddle.
    -- Dev testing shortcut
    if setup_opts.dev then
        require("floating.dev")
    end

    -- types
    require("floating.types")

    -- setting up
    --- @type FLOAT
    local TABLE = {
        actions = require("floating.actions"),
        state = require("floating.state"),

        style_tables = vim.tbl_deep_extend( --
            "force", -- user opts overrides default ".styles"
            {},
            require("floating.styles"),
            setup_opts.styles or {}
        ),

        positions = vim.tbl_deep_extend( --
            "force", -- user opts overrides default ".styles"
            {},
            require("floating.positions"),
            setup_opts.positions or {}
        ),

        attach_style = function(STYLE) end,
        open = function(opts) end,
        toggle = function(STYLE) end,

        draw = function(position, buf, dont_enter) end,
    }

    local draw_setup = require("floating.actions.draw")
    TABLE.draw = draw_setup(TABLE.positions)

    -- this lets the end user just call FLOAT.open({ style_name, pos })
    TABLE.open = function(opts)
        local func = require("floating.actions.open")
        func(TABLE, opts)
    end

    -- this lets the end user just call FLOAT.toggle(style_name)
    TABLE.toggle = function(style_name)
        local func = require("floating.state.toggle")
        func(TABLE, style_name)
    end

    TABLE.attach_style = function(STYLE)
        local func = require("floating.actions.attach_style")
        return func(TABLE, STYLE)
    end

    for _, style in ipairs(TABLE.style_tables) do
        TABLE.attach_style(style)
    end

    -- local duplicate = require("floating.styles.duplicate")
    -- TABLE.attach_style(duplicate)

    for _, style_table in pairs(TABLE.style_tables) do
        if style_table == nil then
            goto continue
        end

        style_table.ATTACH(TABLE)

        ::continue::
    end

    --{{{ default user_commands
    if setup_opts.dont_load_default_user_commands then
        goto skip_defaults
    end
    vim.api.nvim_create_user_command( --
        "FloatingDuplicate",
        function()
            TABLE.toggle("duplicate")
        end,
        { desc = "Toggles a floating window with the current buffer in it." }
    )
    --}}}

    --{{{ default keymaps
    if setup_opts.dont_use_default_keymaps then
        goto skip_defaults
    end
    vim.keymap.set( --
        "n",
        "<leader>fd",
        "<CMD>FloatingDuplicate<CR>",
        {}
    )

    ::skip_defaults::
    --}}}

    --{{{ Dev testing commands
    if setup_opts.dev then
        vim.api.nvim_create_user_command( --
            "FloatAAA",
            function()
                TABLE.toggle("clock")
            end,
            {}
        )

        vim.keymap.set( --
            "n",
            "<leader><leader>k",
            "<CMD>FloatAAA<CR>",
            {}
        )

        vim.api.nvim_create_user_command( --
            "FloatToggleScratch",
            function()
                TABLE.toggle("scratch")
            end,
            {}
        )
        vim.keymap.set( --
            "n",
            "<leader>fs",
            "<CMD>FloatToggleScratch<CR>",
            {}
        )

        vim.api.nvim_create_user_command( --
            "FloatToggleDuplicate",
            function()
                TABLE.toggle("duplicate")
            end,
            {}
        )
        vim.keymap.set( --
            "n",
            "<leader>fd",
            "<CMD>FloatToggleDuplicate<CR>",
            {}
        )

        vim.api.nvim_create_user_command( --
            "FloatToggleDefault",
            function()
                TABLE.toggle("default")
            end,
            {}
        )
        vim.keymap.set( --
            "n",
            "<leader>ff",
            "<CMD>FloatToggleDefault<CR>",
            {}
        )
    end
    --}}}
    return TABLE
end
return M
