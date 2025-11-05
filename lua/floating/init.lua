--{{{ duplicate loading prevention
-- note "floating.nvim" is a reasonably likely name conflict.ini
if vim.g.loaded_mathematicalninja_floating_nvim then
    return
end
vim.g.loaded_mathematicalninja_floating_nvim = true
--}}}

---@type Module_type
local M = {}
M.setup = function(setup_opts)
    --{{{ developer mode

    -- Dev testing shortcut should be off, unless you want to fiddle.
    if setup_opts.dev then
        require("floating.dev")
    end
    --}}}

    --{{{ Structure setup

    ---@type FLOAT
    local TABLE = {
        actions = require("floating.actions"),
        state = require("floating.state"),

        style_tables = {},
        positions = {},

        -- These need references to TABLE, so are defined below.
        attach_style = nil,
        open = nil,
        close = nil,
        hide = nil,

        -- needs the full list of user positions.
        draw = nil,

        toggle = nil,
        toggle_hide = nil,
    }
    --}}}

    --{{{ styles: Load user defined.

    -- Note: if a user defines a "default" style; it will be loaded used as the base foe all the styles.
    local ST = require("floating.styles")
    if setup_opts.extras ~= nil then
        if setup_opts.extras.styles ~= nil then
            for _, name in ipairs(setup_opts.extras.styles) do
                -- TODO: fail protection.
                ST[name] = require("floating.styles.extras." .. name)
            end
        end
    end
    if setup_opts.styles ~= nil then
        for name, style in pairs(setup_opts.styles) do
            ST[name] = style
        end
    end

    TABLE.style_tables = ST
    --}}}

    --{{{ positions: Load user defined.

    local P = require("floating.positions")
    if setup_opts.extras ~= nil then
        if setup_opts.extras.positions ~= nil then
            for _, name in ipairs(setup_opts.extras.positions) do
                -- TODO: fail protection.
                local pos = require("floating.positions.extras." .. name)
                P[name] = pos
            end
        end
    end
    if setup_opts.positions ~= nil then
        for name, pos in pairs(setup_opts.positions) do
            P[name] = pos
        end
    end

    TABLE.positions = P
    --}}}

    --{{{ FLOAT.draw(position, buf, dont_focus)
    -- since this iterates over the full list of positions, we need to initialise it _after_ TABLE.positions.
    TABLE.draw = require("floating.actions.draw")(TABLE.positions)
    --}}}

    --{{{ FLOAT.open({style, pos})

    -- this lets the end user just call FLOAT.open({ style_name, pos })
    TABLE.open = function(opts)
        local func = require("floating.actions.open")
        func(TABLE, opts)
    end
    --}}}

    --{{{ FLOAT.close(bufwin_state)

    -- this lets the end user just call FLOAT.close(bufwin_state)
    TABLE.close = function(bufwin_state)
        local func = require("floating.actions.close")
        func(TABLE, { bufwin_state = bufwin_state })
    end
    --}}}

    --{{{ FLOAT.hide(bufwin_state)

    -- this lets the end user just call FLOAT.hide( bufwin_state)
    TABLE.hide = function(bufwin_state)
        local func = require("floating.actions.hide")
        func(TABLE, { bufwin_state = bufwin_state })
    end

    --}}}

    --{{{ FLOAT.toggle(style_name)

    -- this lets the end user just call FLOAT.toggle(style_name)
    TABLE.toggle = function(style_name, pos)
        local func = require("floating.state.toggle")
        func(TABLE, style_name, pos)
    end
    --}}}

    --{{{ FLOAT.toggle_hide(style_name)

    -- this lets the end user just call FLOAT.toggle_hide(style_name)
    TABLE.toggle_hide = function(style_name, pos)
        local func = require("floating.state.toggle_hide")
        func(TABLE, style_name, pos)
    end
    --}}}

    --{{{ Attaching styles

    TABLE.attach_style = function(STYLE)
        local func = require("floating.attach_style")
        return func(TABLE, STYLE)
    end

    for _, style_table in pairs(TABLE.style_tables) do
        if style_table == nil then
            goto continue
        end
        TABLE.attach_style(style_table)

        ::continue::
    end
    --}}}

    --{{{ default user_commands
    if setup_opts.dont_load_default_user_commands then
        goto skip_default_commands
    end

    -- duplicate
    vim.api.nvim_create_user_command( --
        "FloatingToggleDuplicate",
        function()
            TABLE.toggle("duplicate")
        end,
        { desc = "Toggles a floating window with the current buffer in it." }
    )

    -- scratch
    vim.api.nvim_create_user_command( --
        "FloatingToggleScratch",
        function()
            TABLE.toggle("scratch")
        end,
        { desc = "Toggles a scratch buffer sharing tiletype with the current buffer." }
    )

    -- default
    vim.api.nvim_create_user_command( --
        "FloatingToggleDefault",
        function()
            TABLE.toggle("default")
        end,
        { desc = "Toggles a default buffer/window with no special features." }
    )

    ::skip_default_commands::
    --}}}

    --{{{ default keymaps

    if setup_opts.dont_use_default_keymaps then
        goto skip_default_keymaps
    end
    -- duplicate
    vim.keymap.set( --
        "n",
        "<leader>fd",
        function()
            TABLE.toggle("duplicate")
        end,
        { desc = "Toggles a [f]loating window with a [d]uplicate of the current buffer in it." }
    )

    -- scratch
    vim.keymap.set( --
        "n",
        "<leader>fs",
        function()
            TABLE.toggle("scratch")
        end,
        { desc = "Toggles a [f]loating [s]cratch buffer sharing tiletype with the current buffer." }
    )

    -- default
    vim.keymap.set( --
        "n",
        "<leader>ff",
        function()
            TABLE.toggle("default")
        end,
        { desc = "Toggles a [f]loating de[f]ault buffer/window with no special features." }
    )

    ::skip_default_keymaps::
    --}}}

    --{{{ Dev testing commands

    if setup_opts.dev then
        require("floating.dev")(TABLE)
    end
    --}}}

    return TABLE
end
return M
