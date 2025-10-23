-- duplicate loading prevention
if vim.g.loaded_floating_nvim then
    return
end
vim.g.loaded_floating_nvim = true

-- Dev guard
DEV_FLOATING = true
-- developer mode, should be off, unless you want to fiddle.
-- Dev testing shortcut
if DEV_FLOATING then
    require("floating.dev")
end

-- types
require("floating.types")

-- setting up
--- @type FLOAT
local TABLE = {
    actions = require("floating.actions"),
    state = require("floating.state"),

    -- placeholders

    style_tables = {},
    open = function(opts) end,
    attach_style = function(STYLE) end,
    toggle = function(STYLE) end,
}

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

--- TODO: change to TABLE.STATE.SETUP(TABLE)
require("floating.state.setup")(TABLE)

TABLE.attach_style = function(STYLE)
    local func = require("floating.actions.attach_style")
    return func(TABLE, STYLE)
end

local duplicate = require("floating.styles.duplicate")
TABLE.attach_style(duplicate)

for _, style_table in pairs(TABLE.style_tables) do
    if style_table == nil then
        goto continue
    end

    style_table.ATTACH(TABLE)

    ::continue::
end

--- @param opts {
---     dont_load_default_user_commands: boolean | nil,
---     dont_use_default_keymaps: boolean | nil,
--- }
---     maybe?
---     skip_module: {style_name:boolean}
local function setup(opts)
    --{{{ default user_commands
    if opts.dont_load_default_user_commands then
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
    if opts.dont_use_default_keymaps then
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
end

--{{{ Dev testing commands
if DEV_FLOATING then
    vim.api.nvim_create_user_command( --
        "FloatAAA",
        function()
            TABLE.open({
                style_name = "duplicate",
                pos = "tr",
            })
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
        "FloatToggleTest",
        function()
            TABLE.toggle("duplicate")
        end,
        {}
    )
    vim.keymap.set( --
        "n",
        "<leader><leader>l",
        "<CMD>FloatToggleTest<CR>",
        {}
    )
end
--}}}
return TABLE
