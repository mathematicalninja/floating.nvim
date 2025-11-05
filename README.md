<div align = "center">
My highly personal floating window manager.
</div>

# Why I made this
First and foremost I want a floating window that *sticks around* while I'm doing other things, so I can have notes to look at, function signatures or definitions on screen, or even just a clear space to note down a shopping list before I forget.

# Table of Contents
- [Rationale](#why-I-made-this)
- [Minimal Setup](#setup)
- [Usage](#usage)
- - [Toggle](#toggle)
- - [Toggle_hide](#toggle_hide)
- - [Open, Close, and Hide](#open-close-and-hide)
- - [Default Commands](#default-user-commands)
- - [Default Keymaps](#default-keymaps)
- [Installation](#installation)
- - [Options](#setupopts)
- - - [dev](#setupoptdev)
- - - [positions](#setupopts-positions)
- - - [styles](#setupopts-styles)
- - - [extras](#setupopts-extras)
- - - [dont_load_default_user_commands](#setupopts-dontloaddefaultusercommands)
- - - [dont_use_default_keymaps](#setupopts-dontusedefaultkeymaps)
- - [Full Installation Example](#full-setup-example-lazy)
- [Builtin](#Builtin)
- - [Builtin Styles](#builtin-styles)
- - - [Scratch](#styles-scratch)
- - - [Duplicate](#styles-duplicate)
- - - [Default](#styles-default)
- - [Builtin Positions](#builtin-positions)
- - - [Corners](#positions-corners)
- - - [Pop-ups](#positions-pop-ups)
- - - [Bars](#positions-bars)
- - - [Special](#positions-special)
- - - [Mini-Center](#positions-mini-center)
- [Extras](#extras)
- - [Extra Styles](#extra-styles)
- - - [Clocks](#extra-styles-clocks)
- - [Extra Positions](#extra-positions)
- - - [Clocks](#extra-positions-clocks)
- [User extension](#extension)
- - [Positions](#positions)
- - [Styles Tables](#style)
- [API](#api)
- - [Types](#floating-types)
- - [toggle](#floating-toggle)
- - [toggle_hide](#floating-toggle_hide)
- - [Open](#floating-open)
- - [Hide](#floating-hide)
- - [Close](#floating-close)
- - [attach_style](#floating-attach_style)
- [Types](#types)
- - [bufwin](#types-bufwin)
- - [Enums](#types-enums)
- - [config_and_position](#types-configandposition)
- - [FLOAT](#types-float)
- - [POSITIONS](#types-position)
- - [Setup Options](#types-setupopts)
- - [STYLES](#types-style)
- [Internal Documentation](#internal-documentation)
- - [draw](#floating-draw)
- [Internal Types](#internal-types)
- - [STATE](#types-state)
- - [ACTIONS](#types-actions)


# Setup
minimum config in Lazy:
```lua {filename = "lazy/floating.lua"}
{
    "mathematicalninja/floating.nvim",
    config = function()
        require("floating").setup({})
    end
}
```

# Usage

## toggle

The main functionality of this plugin is the `.toggle` function. This opens new windows if none exist, focuses one if there's an unfocused one, and closes a focused one.


If you want to make your own keymaps, the following syntax should work for any of the [builtin](#builtin-styles), [extra](#extra-styles), or [user defined](#style) styles.

e.g. for [duplicate](#styles-duplicate):

```lua
local float = require("floating")

vim.keymap.set(
    "n",
    "<leader>fd",
    function() 
        float.toggle("duplicate")
    end,
    {}
)
```
There is also the `.open` function to allow multiple windows of the same type to be open (in which case `.toggle` will focus the first one, or close a focused one).



## toggle_hide

There is also the option to call `.toggle_hide` if you'd like to keep the content of the buffer/window, but move it to "the background" rather than closing it.

If you want to make your own keymaps, the following syntax should work for any of the [buitlin](#builtin-styles), [extra](#extra-styles), or [user defined](#style) styles.

e.g. for [scratch](#styles-scratch):

```lua
local float = require("floating")

vim.keymap.set(
    "n",
    "<leader>fs",
    function() 
        float.toggle_hide("scratch")
    end,
    {}
)
```

## open, close, and hide

If you want greater granularity over where windows are opened, or shortcut closing/hiding them, then the functions [open](#floating-open), [close](#floating-close), and [hide](#floating-hide) are provided.

Example:

```lua
local float = require("floating")

vim.keymap.set(
    "n",
    "<leader>fo",
    function() 
        float.open({
            style_name = "scratch",
            pos = "mc",
            is_not_scratch = true,
        })
    end,
    {desc = "[o]pens a float for shopping lists"}
)

vim.keymap.set(
    "n",
    "<leader>fc",
    function() 
        float.close({
            pos = "mc",
        })
    end,
    {desc = "[c]loses the floating shopping list"}
)


vim.keymap.set(
    "n",
    "<leader>fh",
    function() 
        float.hide({
            pos = "mc",
        })
    end,
    {desc = "[h]ides the floating shopping list"}
)
```



## Default User Commands
`setup_opts.dont_load_default_user_commands` is used to **skip** default user command creation, so if left nil, then defaults are loaded.

The module comes with a command for each [Builtin Styles](#builtin-styles).
Loads the following Vim commands:
- [`FloatingToggleDuplicate`](#styles-duplicate)
- [`FloatingToggleScratch`](#styles-scratch)
- [`FloatingToggleDefault`](#styles-default)

each calling [toggle](#toggle) for that style.



## Default Keymaps
`setup_opts.dont_use_default_keymaps` is used to **skip** default user keymap creation, so if left nil, then defaults are loaded.

The module comes with keymaps for each of the [Builtin Styles](#builtin-styles) in "n" mode.
- [Scratch](#styles-scratch): "<leader>fs"
- [Duplicate](#styles-duplicate): "<leader>fd"
- [Default](#styles-default): "<leader>ff"


# Installation
[Example](#full-setup-example-lazy)

Calling `local FLOAT = require("floating").setup(opts)` creates an object (in this case `FLOAT`) that can be used in user keymaps etc. 

Note: `.setup()` _needs_ to be called.


I developed this with Lazy as my manager. If it has errors loading with other managers please let me know and I'll try extending it to work with them.


```lua {filename = "lazy/floating.lua"}
{
    "mathematicalninja/floating.nvim",
    -- If you wish to extend functionality you may need dependencies.
    dependencies = { },
    config = function()
        local float = require("floating").setup({
            -- dev = true,
            -- positions = {},
            -- styles = {},
            -- extras = {
            --      positions = {},
            --      styles = {},
            -- },
            -- dont_load_default_user_commands = false,
            -- dont_use_default_keymaps = true,
        })
    end
}
```

## Setup_Opts
The options for the `.setup` function are contained in the type `Setup_Opts`.

```lua
---@alias Setup_Opts {
---     dev: boolean | nil,
---     dont_load_default_user_commands: boolean | nil,
---     dont_use_default_keymaps: boolean | nil,
---     styles:{[style_name]:STYLE},
---     positions: {[position_abrv]:POSITION},
---     extras: {
---         positions:extra_positions[],
---         styles:extra_styles[],
---     }
--- }
```

### Setup_Opts - dev
Type: boolean | nil
Default value: nil
Default behaviour: does ***nothing***, as it should.
Purpose:

Used for testing purposes, exposes a user_commands for each window position, or allows me to create _temporary_ and possibly _buggy_ commands/keymaps while building.

No guarantee it won't cause problems, use at your own risk.

### Setup_Opts - positions
Type: {[[position_abrv](#types-positionabrv)]:[POSITION](#types-position)}
Default value: {}
Default behaviour: loads the positions from [builtin](#builtin-positions)
Purpose:
Allows end users to pass in a table of their own custom [positions](#types-position).

### Setup_Opts - styles
Type: {[[style_name](#types-stylename)]:[STYLE](#types-style)}
Default value: {}
Default behaviour: loads the styles from [builtin](#builtin-styles)
Purpose:
Allows end users to pass in a table of their own custom [styles](#types-style).

### Setup_Opts - extras
Type: {
    styles:[extra_styles](#types-extrastyles)[],
    positions:[extra_positions](#types-extrapositions`)[],
}
Default value: nil
Default behaviour: does nothing.
Purpose:
This is used to load in more esoteric styles and positions that I though most users would have little intererst in, but I have don't want to clutter up my .config files with.

#### Setup_Opts - extras.styles
Type: [extra_styles](#types-extrastyles)[] | nil
Default value: nil
Default behaviour: does nothing.
Purpose:
a _list_ of _string_ that are the names of the [extra styles](#extra-styles) to be loaded.

Options:
```lua
extras.styles = {
    "clock_tl",
}
```

#### Setup_Opts - extras.positions
Type: [extra_positions](#types-extrapositions`)[] | nil
Default value: nil
Default behaviour: does nothing.
Purpose:
a _list_ of _string_ that are the names of the [extra positions](#extra-positions) to be loaded.

Options:
```lua
extras.positions = {
    "clock_tl",
}
```


### Setup_Opts - dont_load_default_user_commands
Type: boolean | nil
Default value: nil
Default behaviour: loads the [default commands](#default-user-commands).
Purpose:
loads [commands](#default-user-commands) for each [builtin style](#builtin-styles) (e.g. FloatToggleScratch) so you can set your own keymaps or use via command line. 

### Setup_Opts - dont_use_default_keymaps
Type: boolean | nil
Default value: nil
Default behaviour: loads the [default keymaps](#default-keymaps).
Purpose:
loads the default [keymaps](#default-keymaps) for each [builtin style](#builtin-styles) to allow "out of the box" functionality.



## Full Setup Example - Lazy

A full (lazy) example that I use for an international clock popup,

```lua
{
    "mathematicalninja/floating.nvim",
    config = function()
        local opts = {
            dev = true,
            positions = {
                clock_tr = function()
                    --- @module "floating"

                    --- @alias position_abrv
                    --- | "clock_tr"

                    --- @alias style_name
                    --- | "clock_tr"

                    --- @type Setup_Opts
                    ---@type config_and_position
                    local R = {}

                    local col = vim.o.columns

                    R.pos = "clock_tr"
                    R.name_location = "footer"
                    R.config = {
                        width = 5,
                        height = 1,
                        col = col,
                        row = 0,
                        anchor = "NW",
                        title = "",
                        title_pos = "center",
                        relative = "editor",
                        style = "minimal", -- No extra UI elements, e.g. status bar.
                        border = { "", "", "", "", "", "═", "╚", "║" },
                    }

                    return R
                end,
            },
            styles = {
                clock_tr = {
                    name = "clock_tr",
                    positions = { "clock_tr" },
                    dont_focus = true,

                    INIT = function(FLOAT)
                        FLOAT.state.style_data.clock_tl = {}
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

                        STATE.style_data.clock_tl = {
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
                            { opts.state.style_data.clock_tl.time }
                        )
                    end,
                },
            },
            extras = { --
                positions = { "clock_tl" },
                styles = { "clock_tl" },
            },
            dont_load_default_user_commands = false,
            dont_use_default_keymaps = false,
        }
        local float = require("floating").setup(opts)

        vim.keymap.set("n", "<leader><leader>p", function()
            float.toggle("clock_tr")
        end, {})
    end,
}
```

# Builtin

This plugin comes with some builtin "[styles](#style)" for floating windows and "[positions](#positions)" to put them in.

## Builtin Styles
see [styles](#style) for details.

### Styles - scratch
`"scratch"`
Fills a [corner](#positions-corners) with a "scratch" buffer, matching the language of the buffer you call the function from.

Allows for language highlighting while making quick mock-ups or psudo-code.

Example:
```lua
local float = require("floating")

vim.keymap.set( --
    "n",
    "<leader>fs",
    function()
        float.toggle("scratch")
    end,
    { desc = "Toggles a [f]loating [s]cratch buffer sharing tiletype with the current buffer." }
)
```

### Styles - Duplicate
`"duplicate"`
Fills a [corner](#positions-corners) with the current buffer.

Useful for 
- keeping a function signature on screen while deeper in it's body.
- holding a type signature that's being used in a different place.
- referencing a similar piece of code.

Example:
```lua
local float = require("floating")

vim.keymap.set( --
    "n",
    "<leader>fd",
    function()
        float.toggle("duplicate")
    end,
    { desc = "Toggles a [f]loating window with a [d]uplicate of the current buffer in it." }
)
```

### Styles - Default
`"default"`
A completely ordinary buffer.

90% of it's purpose if to be a baseline for the other styles so you don't need to code in every property.

10% is to allow a throwaway buffer that has a special one off use, e.g. shopping lists. 

Example:
```lua
local float = require("floating")

vim.keymap.set( --
    "n",
    "<leader>ff",
    function()
        float.toggle("default")
    end,
    { desc = "Toggles a [f]loating de[f]ault buffer/window with no special features." }
)
```

## Builtin Positions
See [positions](#positions) for details.

Builtin positions can be indexed by [name](#types-positionabrv), for use in a `position_abrv[]` list when opening a [style](#style) using [FLOAT.open()](#floating-open)

#### name_location
[!NOTE] the builtin positions allow for a title/footer to be indexed by the `name_location` field in a style's definition.

This will use titles (above the window) if the floating window is at the bottom of the screen,
and a footer (below the window) if the floating window is at the top or middle of the screen.

```lua
my_style = {
    -- ...
    style = function(opts)
    --
        conf[opts.conf_pos.name_location] = "Wow, a buffer."
        vim.api.nvim_win_set_config(opts.bufwin.win, conf)
    end
}
```


### Positions Corners
valid values:
```lua
local corners = {
    "tr", -- top right
    "tl", -- top left
    "br", -- bottom right
    "bl", -- bottom left
}
```
45% of the screen in one of the corners, with rounded border.

I like a little bit more space around it then 50% size would give, especially when opening multiple windows.


### Positions pop-ups
valid values:
```lua
local corners = {
    "bp", -- bottom pop-up
    "cp", -- center pop-up
    "tp", -- top pop-up
}
```
Small "pop-up" 1 row tall, and about 45% of the screen wide, 


### Positions bars
valid values:
```lua
local corners = {
    "bb", -- bottom bar
    "tb", -- top bar
}
```
Full bar 1 row tall across the whole screen.

### Positions Special
valid values:
```lua
local specials = {
    "mc",
}
```

#### Positions Mini-Center
A very mini (1/16th of the area) window in the dead center of the screen.

# Extras
There are some more unusual [styles](#extra-styles) and [positions](#extra-positions) that I feel are not needed for most uses, but I wanted them for some personal edge-cases.

They can be loaded in by name in as shown [here](#setupopts-extras).

## Extra Styles
More unusual styles that I feel most unhelpful, but I found enough of a use for to keep in.

Loaded in by name as shown [here](#setupopts-extrasstyles).


### Extra Styles - Clocks
valid values:
```lua
local corners = {
    "clock_tl", -- top left corner clock
    "clock_tr", -- top right corner clock
    "clock_bl", -- bottom left corner clock
    "clock_br", -- bottom right corner clock
}
```

A pop-up clock showing the current time, I use it in full-screen mode so I can forget what the time is, but check when I feel like it, great for zen coding.



## Extra Positions
More unusual positions that I feel most unhelpful, but I found enough of a use for to keep in.

Loaded in by name as shown [here](#setupopts-extraspositions).

### Extra Positions - Clocks
valid values:
```lua
local corners = {
    "clock_tl", -- top left corner clock
    "clock_tr", -- top right corner clock
    "clock_bl", -- bottom left corner clock
    "clock_br", -- bottom right corner clock
}
```

A 5 wide popup (with partial border) in the corner of the screen. Ideal for writing "14:22" in.

# Extension

This module has 4 major components, two of which are designed for user extensions: Styles and Positions.

## Positions
[Example](#positions-example)

Positions are *functions* that return a table with signature:
```lua
---@alias Position_Return {
---     pos: position_abrv,
---     name_location:"footer" | "title",
---     config:vim.api.keyset.win_config,
--- }
```
This plugin is designed to allow users to add positions that they want floating windows in (e.g. I like a tiny clock).

This extension comes in the form of the `opts.positions` table which has key value pairs of type 

```lua
---@alias Setup_Opts {
---     positions: {[position_abrv]:POSITION},
--- ...
--- }
```
See [position_abrv](#types-positionabrv), [POSITIONS](#types-position).

### Purpose

The reason that these are coded as functions that return tables rather than hard coded tables is to allow relative calculations on position and size to happen when the window is opened.

e.g.

```lua
    local col = math.floor(vim.o.columns * 0.275)
```

### Return

Note: `position.pos` *must* match the key used to index it in the `opts.positions` table, as the `.pos` is used to index the created table.

#### pos
pos.name has type [`position_abrv`](#types-positionabrv) which is an extendable collection of strings:

When a new position is added it's abrv can be appended by duplicating the alias `special_abrv`, e.g. to add a "clock":

```lua
---@alias special_abrv
--- | "clock"
```
this gives a duplicate warning, but allows types to be used without error, only if they are defined in the code. This is especially useful in `Styles` where a list of positions is needed, and can easily be typo'd.

#### name_location
type `"header"|"footer"` tells the module whether a window's (optional) title goes above (header) or below (footer) the window.

Names are defined in style see [style.style](#types-stylestyle)
```lua
style = function(opts)
    -- ...
    conf[opts.conf_pos.name_location] = "UTC" 
    -- ...
end

```

#### config
This config is calculated when this position function is called, and allows dynamic config settings.
The result is ultimately merged with [defaults](#styles-default) and passed tovim.api.nvim_open_win.

See |api-win_config| in nvim help for details.

Some notable config options:
```lua
{
    width = 5,
    height = 1,
    col = 1,
    row = 1,
    title = "",
    title_pos = "center",
    footer = "",
    footer_pos = "left",
    focusable = false,
}
```

#### Positions - Example
An example is the "clock" I have briefly pop up on my screen:
```lua
---@alias special_abrv
--- | 'clock_tl'

opts.positions = {
---@type POSITION
clock_tl = function()
    return {
        pos = "clock_tl",
        name_location = "footer",
        config = {
            width = 5,
            height = 1,
            col = 1,
            row = 1,
            title = "",
            title_pos = "center",
            relative = "editor",
            style = "minimal", -- No extra UI elements, e.g. status bar.
            border = "shadow",
        },
    }
end
}
```

## Style
[Example](#styles-example)

Styles are class like tables (as classes don't truly exist in lua - which is tables all the way down) that have a collection of Methods and some hard coded values.


### Purpose
Styles are used to "fancify" windows or to add functionality after it's been opened.

e.g. Setting file-type, `put`ing text, or setting up auto-commands.

### Fields
```lua
---@alias STYLE {
--- name: style_name,
--- positions: position_abrv[],
--- dont_focus: boolean | nil,
--- is_not_scratch: boolean | nil,
--- INIT: fun(FLOAT:FLOAT),
--- setup: fun(STATE:STATE),
--- style: (fun(opts:{
---             state:STATE,
---             bufwin:bufwin,
---             conf_pos:config_and_position,
---             data:table, --- individual float styles define what their data looks like.
---         })),
--- push: (fun(
---             STATE:STATE,
---             bufwin_pos:bufwin_pos,
---         )),
--- pop: (fun(
---             STATE:STATE,
---             bufwin_state:bufwin_state,
---         )),
--- }
```


### Styles Example
```lua
opts.styles = {
    clock = {
        name = "clock",
        positions = { "clock_tl" },
        dont_focus = true,

        INIT = function(FLOAT)
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
}
```

# API
2 of the 4 major components of this plugin ([STATE](#types-state) and [ACTIONS](#types-actions)) are designed for a mix of [_internal_](#internal-functions) use and user _consumption_, some of which is exposed and documented here.

The other 2 ([POSITIONS](#positions) and [STYLES](#style)) are designed to provide extensibility to the user,

Therefore this plugin comes with some "out of the box" functions that you can use to allow greater granularity in control.

## Floating Types
While making this plugin I ensured (as I always try to) that there was a strict type system in place, this is opt in in lua so feel free to ignore it.

While more types are defined for internal use, I document [here](#types) the types that are exposed for user consumption.

Using LuaDocs allows 
```lua
---@module "floating"
```
which will import the types from the module as long as lua can resolve `require("floating")` which is the case when using Lazy.

Alternatively *most* of the plugin's types can be found in the file `floating/dev.lua`. Note that `style_name` and `position_abrv` are defined and extended in the files relating to those positions/styles so couldn't be fully included here.

## Exposed functions
Here follows the functions that can be accessed via 
```lua
require("floating")[function_name]()
```
along with:
1. Their Purpose
1. Their Parameters
1. Their Return Value (if not nil)
1. Example Usage

## Floating toggle
[Example](#example-floattoggle)

### Purpose
Opens new windows, switches to them if you de-focus them (e.g. with "<C-w>w"), and *closes* them if they're focused.

Automatically chooses position from the style's chosen preferences. See [style.positions](#tystpos

To *hide* instead of closing see: [toggle_hide](#floating-togglehide)

### Parameters
type: [style_name](#types-stylename)

a string, the name of the style to toggle

### Example - float.toggle()
```lua
local float = require("floating").setup()
vim.keymap.set(
    "n",
    "<leader>fd",
    function() 
        float.toggle("duplicate")
    end,
    {}
)
```

## Floating toggle_hide
[Example](#example-floattogglehide)

### Purpose
Opens new windows, switches to them if you de-focus them (e.g. with "<C-w>w"), and *hides* them if they're focused.

Automatically chooses position from the style's chosen preferences. See [style.positions](#tystpos

To *close* instead of hiding see: [toggle_close](#floating-toggleclose)

### Parameters
type: [style_name](#types-stylename)

a string, the name of the style to toggle

### Example - float.toggle_hide()
```lua
local float = require("floating").setup()
vim.keymap.set(
    "n",
    "<leader>fd",
    function() 
        float.toggle_hide("duplicate")
    end,
    {}
)
```


## Floating Open
[Example](#example-floatopen)

### Purpose
Allows a user to open a *specific* float style in a *specific* position.

Mainly for when you want to allow multiple windows of the same style to be open at once, or to open styles in unusual positions.


### Parameters
Takes a single option table with the following fields:

[`style_name`](#types-stylename) is the name of the (possibly user defined) style.
*required* field

[`pos`](#types-positionabrv) is the abbreviation of the (possibly user defined) position.
*required* field

`is_not_scratch` is used to make a "real" buffer as this plugin defaults to scratch buffers, see |vim.api.nvim_create_buf|.
default value: nil
default behaviour: new buffer (if created) is a throwaway buffer.

`buf` is used to specify a buffer if an already existing one is to be used in the float (e.g. `buf = 0` for duplicate buffers).
default value: nil
default behaviour: a new buffer is created.

### Return
type: [config_and_position](#types-configandposition)
```lua
---@alias config_and_position {
---     config:vim.api.keyset.win_config,
---     pos:position_abrv,
---     name_location: "footer"|"title",
--- }
```

### Example - float.open()
```lua
local float = require("floating")
---@type Actions.Open.opts
open_opts = {
    style_name = "scratch",
    pos = "tr",
    is_not_scratch = nil,
    buf = nil,
}

local float = require("floating").setup()
vim.keymap.set(
    "n",
    "<leader>fo",
    function()
        float.open(open_opts)
    end,
    {})
```

## Floating Hide
[Example](#example-floathide)

### Purpose
Allows a user to *hide* a floating window based on [*style*](#types-stylename) or [*position*](#types-positionabrv).

Allows for more manual control, e.g. making semi-permanent scratch buffers that hide until you close them.

### Parameters
takes a single option table with the following fields:

[`style_name`](#types-stylename) is the name of the (possibly user defined) style.

[`pos`](#types-positionabrv) is the abbreviation of the (possibly user defined) position.

### Behaviour
If only a style name is provided:
hides the last window of that style opened.

If only a position is provided:
hides the last opened window in that position.

If both are provided:
hides the most recently opened window that is both in that position and of that style.

If neither are provided:
does nothing.


### Example - float.hide()
```lua
local float = require("floating").setup()

vim.keymap.set(--
    "n",
    "<leader>fh",
    function()
        float.hide({pos="tl", style="scratch"})
    end,
    { desc = "hides the scratch window in the top left" }
)
```

## Floating Close
[Example](#example-floatclose)

### Purpose
Allows a user to *close* a floating window based on [*style*](#types-stylename) or [*position*](#types-positionabrv).


### Parameters
takes a single option table with the following fields:

[`style_name`](#types-stylename) is the name of the (possibly user defined) style.

[`pos`](#types-positionabrv) is the abbreviation of the (possibly user defined) position.

### Behaviour
If only a style name is provided:
closes the last window of that style opened.

If only a position is provided:
closes the last opened window in that position.

If both are provided:
closes the most recently opened window that is both in that position and of that style.

If neither are provided:
does nothing.

### Example - float.close()
```lua
local float = require("floating")

vim.keymap.set(--
    "n",
    "<leader>fh",
    function()
        float.close({pos="tl", style="scratch"})
    end,
    { desc = "closes the scratch window in the top left" }
)
```

## Floating attach_style
[Example](#example-floatattachstyle)

### Purpose
Used internally to add [styles](#style) to the [state](#types-state) object.

Technically could allow a user to add styles *after* [FLOAT.setup](#types-setupopts) has been run. I can think of times where this might be helpful, so it's an exposed function.

### Parameters
[STYLE](#types-style)

### Example - float.attach_style()
```lua
local float = require("floating")

local style_table = {
    -- user definition
}

float.attach_style(style_table)
```

# Types

## Types - `bufwin`
```lua
---@alias bufwin { buf:integer, win:integer }
```

#### purpose
Type used to simplify passing parameters.

### Types `bufwin_pos`
```lua
---@alias bufwin_pos {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
--- }
```
#### purpose
Type used to simplify passing parameters.


### Types `bufwin_style`
```lua
---@alias bufwin_style {
---     buf:integer,
---     win:integer,
---     style_name:style_name,
--- }
```
#### purpose
Type used to simplify passing parameters.


### Types `bufwin_state`
```lua
---@alias bufwin_state {
---     buf:integer,
---     win:integer,
---     position: position_abrv,
---     style_name:style_name,
--- }
```
#### purpose
Type used to *track* the state of a bufwin, most notably used in [STATE.window_states](#types-statewindowstates).

## Types - Enums

### Types `extra_styles`
```lua
---@alias extra_styles
--- | "clock_tl"
--- | "clock_tr"
--- | "clock_bl"
--- | "clock_br"
```
#### purpose
Optional extra styles that I have not finalised, or think are impractical and niche.


## Types `position_abrv`
```lua
---@alias position_abrv
--- | corner_abrv
--- | popup_abrv
--- | bar_abrv
--- | special_abrv
--- | extra_positions
```
#### purpose
The full collection of abbreviations used to identify valid positions.


### Types `corner_abrv`
```lua
---@alias corner_abrv
--- | 'tr'  # Top Right
--- | 'tl'  # Top Left
--- | 'br'  # Bottom Right
--- | 'bl'  # Bottom Left
```
#### purpose
Used to index [corner positions](#positions-corners).


### Types `popup_abrv`
```lua
---@alias popup_abrv
--- | 'tp'  # Top Pop-up -- small pop-up
--- | 'cp'  # Center Pop-up -- small pop-up
--- | 'bp'  # Bottom Pop-up -- small pop-up
```
#### purpose
Used to index [popup positions](#positions-pop-ups).

### Types `bar_abrv`
```lua
---@alias bar_abrv
--- | 'tb'  # Top Bar -- full bar across top
--- | 'bb'  # Bottom Bar -- full bar across bottom
```
#### purpose
Used to index [bar positions](#positions-bars).

### Types `special_abrv`
```lua
---@alias special_abrv
--- | 'mc' # Mini Center -- a mini popup in the very center
```
#### purpose
Used to index [special positions](#positions-special).

### Types `extra_positions`
```lua
---@alias extra_positions
--- | "clock_tl"
--- | "clock_tr"
--- | "clock_bl"
--- | "clock_br"
```
#### purpose
Used to index [extra positions](#extra-positions).

## Types `config_and_position`
```lua
---@alias config_and_position {
---     config:vim.api.keyset.win_config,
---     pos:position_abrv,
---     name_location: "footer"|"title",
--- }
```

#### purpose
The full options object that gets used internally by the [draw](#floating-draw) function, detailing where to open a window, where its "title"/"footer" goes, and the valid nvim config.


## Types `FLOAT`
```lua
---@alias FLOAT {
---     actions: ACTIONS,
---     state: STATE,
---     attach_style: fun(STYLE:STYLE),
---     style_tables: {[style_name]:STYLE},
---     positions: {[position_abrv]:POSITION},
---     draw: FLOAT.draw,
---     open: fun(
---         opts:{
---              style_name:style_name,
---              pos:position_abrv,
---              is_not_scratch:boolean | nil,
---              buf: integer | nil,
---         },
---     ),
---     close: fun(bufwin_state:bufwin_state),
---     hide: fun(bufwin_state:bufwin_state),
---     toggle: fun(style_name:style_name, pos: position_abrv | nil),
---     toggle_hide: fun(style_name:style_name, pos: position_abrv | nil),
--- }
```

#### purpose
The ___Core___ of the plugin, holds the [STATE](#types-state) of the plugin, [exposes functions](#exposed-functions) to the user, and holds the configured [positions](#positions) and [styles](#style)

## Types `POSITION`
```lua
---@alias POSITION fun():config_and_position
```

#### purpose
The "config _function_" for a [position](#positions).

Returns the [config_and_position](#types-configandposition) that is passed into the [draw function](#floating-draw) that defines what a window looks like and where it is.

Function is called when a window is to be opened, allowing for dynamic configuration (e.g. checking current number of lines/columns).

## Types `STYLE`
```lua
---@alias STYLE {
---     name: style_name,
---     positions: position_abrv[],
---     dont_focus: boolean | nil,
---     is_not_scratch: boolean | nil,
---     INIT: (fun(
---                 FLOAT:FLOAT,
---             ):nil) | nil,
---     setup: (fun(STATE:STATE)),
---     style: (fun(opts:{
---                 state:STATE,
---                 bufwin:bufwin,
---                 conf_pos:config_and_position,
---                 data:table, --- individual float styles define what their data looks like.
---             }):nil),
---     push: (fun(
---                 STATE:STATE,
---                 bufwin_pos:bufwin_pos,
---             ):nil),
---     pop: (fun(
---                 STATE:STATE,
---                 bufwin_state:bufwin_state,
---             ):nil),
--- }
```

#### purpose
The full configuration that is provided to define the look, internal state storage, and any behaviour/functionallity of the window.


#### Types - STYLE.name
type: [style_name](#types-style_name)
Required field.
 
`style_name` are simply strings that are extended as with `position_abrv`.
This is used in two major ways:
1. indexing in the data that the style stores in the global STATE object.
2. calling the specific style's methods when handling a floating window.

This means that it *must* be identical to the key used to index it in the `opts.styles` table.

#### Types - STYLE.positions
type: [position_abrv](#types-position_abrv)[]
Required field.

In a `STYLE` table, `positions` is a _list_ of positions that can be used to open a window. They are checked in order to see if the global STATE object has an open window in that position and then if uses the first free (or opens in the 1st position in from the list if they are all occupied).

#### Types - STYLE.dont_focus
type: boolean | nil
default value: nil
default behaviour: moves into the window when it's been set up.

If set to `true` then the window will not focus on creation or through `require("floating").toggle(style)`.

Used for "info" windows rather than "editing" windows.

#### Types - STYLE.is_not_scratch
type: boolean | nil
default value: nil
default behaviour: makes an editable buffer.

If set to `true` then the buffer will be created as a scratch buffer see |help:nvim_create_buf()| for more details..

#### Types - style.INIT
type: (fun(FLOAT:[FLOAT](#types-float):nil) | nil
default value: function(FLOAT) end

This is called for each `STYLE` table when the _module_ is loaded, before each style is initialised, `STATE[style_name] = {}` is set.

This allows the user to define a data object that can be used *during* [style.setup](#types-stylestyle)
 which is needed if the style needs some data from *before* entering the new window (e.g. old buffer's file-type) to decide what it's doing.

See [STATE.style_data](#types-state-style_data)

#### Types - style.setup
type: fun(state:[state](#types-state):nil
required field.

This function is called right before a new window (or it's buffer) is opened/created, so data can be stored in `STATE[style_name]` and window configuration overrides can be calculated.

#### Types - style.style
type:fun(opts:{
    state:[STATE](#types-state),
    bufwin:[bufwin](#types-bufwin),
    conf_pos:[config_and_position](#types-configandposition),
    data:[table](#types-statestyledata),
})
required field.

This is the function that's called right after a window is opened (usually from inside the window) to allow for the *actual styling* to happen. E.g. setting file-type, inserting text, and so on.

#### Types - style.pop and style.push
These are largely ***not***-needed, indeed their `default` does nothing. They exist to allow individual styles to hold state for multiple windows.

#### Types - style.push
largely ***not***-needed,
`style.push` could store a list of currently open windows of a type, allowing cycling through that list as the "in-focus" window.

```lua
---@alias push fun(
---        STATE:STATE,
---        bufwin_pos:bufwin_pos,
---    ):nil
```

#### Types - style.pop
largely ***not***-needed,
`style.pop` is used to clean up this data when a window is closed.

```lua
---@alias pop fun(
---        STATE:STATE,
---        bufwin_pos:bufwin_pos,
---    ):nil
```

## Types Setup_Opts
see [Installation: Options](#setupopts) for more details.

The options that are passed into the modules `requires("floating").setup(opts)`

```lua
---@alias Setup_Opts {
---     dev: boolean | nil,
---     dont_load_default_user_commands: boolean | nil,
---     dont_use_default_keymaps: boolean | nil,
---     styles:{[style_name]:STYLE},
---     positions: {[position_abrv]:POSITION},
---     extras: {
---         positions:extra_positions[],
---         styles:extra_styles[],
---     }
--- }
```

## Setup_Opts `STATE`
Note that this has _internal_ types that you really shouldn't be messing around with, but one type is exposed (a class) to allow you to add your own data structure for new style types.

## Setup_Opts `STATE.style_data`
```lua
-- adds type support for this style's data.
---@class STATE.style_data
---@field duplicate? {
---     old_buf:integer,
---     bufwins : bufwin_pos[],
--- }
```
#### purpose
The main goal is to store temporary data for a *single* buffer *during* the creation process.

If more permanent data is needed or multiple buffers need data for a single style type then see [`style.push`](#types-stylepush) and [`style.pop`](#types-stylepop).


# Internal Documentation
The following is included for completeness (and to assist in future development), but should not be used externally, though it could *technically* be accessed (e.g. require("floating").state.get_last_index() is a valid function call) there is **no guarantee** that these internal functions and behaviours won't be changed in breaking ways.

## Internal Functions

## Floating draw
[Example](#example-floatdraw)

### Purpose
Used internally by the [open](#floating-open) function to draw the window after open sets up data, allowing [STATE.style_data](#setupopts-state) to setup data from _before_ the window is drawn.

### Parameters
opts:{
    position:[position_abrv](#types-positionabrv),
    buf:integer | nil,
    dont_focus:boolean | nil,
}

### Return
{
    bufwin:[bufwin](#types-bufwin) , -- {-1, -1} for a failed attempt.
    draw_opts:[config_and_position](#types-configandposition)
}

### Example - float.draw()
```lua
local float = require("floating")

float.draw({
    position="tr",
    buf=0,
    dont_focus=true,
})
```



# Internal Types

## Types `STATE`
```lua
---@alias STATE {
---     window_states:bufwin_state[],
---     style_data:STATE.style_data,
---     check:fun(
---         STATE:STATE,
---         position_abrv:position_abrv,
---     ),
---     get_last_win:(fun(
---         STATE:STATE,
---     ):bufwin_state | nil),
---     get_last_index:(fun(
---         STATE:STATE,
---     ):integer | nil),
---     get_first_free_position:(fun(
---         STATE:STATE,
---         position_list:position_abrv[],
---     ):position_abrv),
---     push_win:(fun(
---         STATE:STATE,
---         bufwin_state:bufwin_state,
---     ):boolean),
---     toggle:(fun(
---         FLOAT:FLOAT,
---         style_name:style_name,
---     )),
---     toggle_hide:(fun(
---         FLOAT:FLOAT,
---         style_name:style_name,
---     )),
--- }
```

### Types `STATE.window_states`
[bufwin_state](#types-bufwinstate)[]

#### purpose
A global list of open windows.

### Types `STATE.style_data`
```lua
---@class STATE.style_data
```

#### purpose
A _blank_ slate for styles to impose their own data structure into.
e.g.
```lua
---@class STATE.style_data
---@field scratch? {
---     filetype:string,
--- }
```

### Types `STATE.check`
```lua
---@type fun(
---     STATE:STATE,
---     position_abrv:position_abrv,
--- ),
```
See [STATE](#types-state), [position_abrv](#types-positionabrv)

#### purpose
Checks to see if a specific position is _empty_ to open a new window in it. Ignores closed windows.

### Types `STATE.get_last_win`
```lua
---@type fun(STATE:STATE):(bufwin_state | nil)
```
See [STATE](#types-state), [bufwin_state](#types-bufwinstate)

#### purpose
Returns the most recently opened window. Hidden windows are _ignored_.

### Types `STATE.get_last_index`
```lua
---@type fun(STATE):(integer | nil)
```
See [STATE](#types-state).

#### purpose
returns the index of the last opened window in the [STATE.window_states](#types-statewindowstates) table.

_Ignores_ hidden windows.

### Types `STATE.get_first_free_position`
```lua
---@type fun(
---     STATE:STATE,
---     position_list:position_abrv[],
--- ):position_abrv
```
See [STATE](#types-state), [position_abrv](#types-positionabrv)

#### purpose
given a list of positions returns the first one that doesn't contain an _open_ window. If all are full, returns the _first_ position_abrv in the list.

### Types `STATE.push_win`
```lua
---@type fun(
---     STATE:STATE,
---     bufwin_state:bufwin_state,
--- ):boolean
```
See [STATE](#types-state), [position_abrv](#types-bufwinstate).

#### purpose
Adds a bufwin along with it's position and style to the STATE.

### Types `STATE.toggle`
```lua
---@type fun(
---     FLOAT:FLOAT,
---     style_name:style_name,
--- )
```
See [FLOAT](#types-float), [style_name](#types-stylename)

#### purpose
Is exposed to user as the [toggle](#floating-toggle) function, without the [FLOAT](#types-float) needing to be passed.

Full details in [toggle](#floating-toggle).

### Types `STATE.toggle_hide`
```lua
---@type fun(
---     FLOAT:FLOAT,
---     style_name:style_name,
--- )
```
See [FLOAT](#types-float), [style_name](#types-stylename)

#### purpose
Is exposed to user as the [toggle_hide](#floating-toggle_hide) function, without the [FLOAT](#types-float) needing to be passed.

Full details in [toggle](#floating-toggle_hide).

## Types `ACTIONS`
```lua
---@alias ACTIONS {
---     close:ACTIONS.close,
---     close_last:ACTIONS.close_last,
---     draw:ACTIONS.draw,
---     ensure_buffer:ACTIONS.ensure_buffer,
---     hide:ACTIONS.hide,
---     new_scratch_buffer:ACTIONS.new_scratch_buffer,
---     open:ACTIONS.open,
---}
```

#### purpose
The collection of non-state-dependant functions that the plugin needs to be able to perform.

### Types `ACTIONS.draw`
```lua
---@alias ACTIONS.draw fun(
---   position:position_abrv,
---   buf:integer | nil,
---   dont_focus:boolean | nil,
--- ): {
---   bufwin:bufwin, -- {-1, -1} for a failed attempt.
---   draw_opts:config_and_position,
--- }
```
See [position_abrv](#types-positionabrv), [bufwin](#types-bufwin), and [config_and_position](#types-configandposition).

#### purpose
Is exposed to the rest of the plugin (not the user) as [FLOAT.draw](#floating-draw).

Used for creating new windows while allowing setup to be separated.

### Types `ACTIONS.open`
```lua
---@alias ACTIONS.open fun(
---     FLOAT:FLOAT,
---     opts: {
---         style_name:style_name,
---         pos:position_abrv,
---         is_not_scratch:boolean | nil,
---         buf: integer | nil,
---     }
--- )
```
see [FLOAT](#types-float), [style_name](#types-stylename), [position_abrv](#types-positionabrv).

#### purpose
Opens a particular [style](#style) in a particular [position](#positions).

Exposed to the user without the [FLOAT](#types-float) dependency as [FLOAT.opne](#floating-draw).

### Types `ACTIONS.close`
```lua
---@alias ACTIONS.close fun(
---     FLOAT:FLOAT,
---     opts: {
---         bufwin_state:bufwin_state | nil,
---         pos:position_abrv | nil,
---         style_name:style_name | nil,
---     },
--- )
```
see [FLOAT](#types-float), [bufwin_state](#types-bufwinstate), [position_abrv](#types-positionabrv)

#### purpose
Closes a specific window, or the most recent one matching position or state.

Priorities:
1. Specific bufwin_state given.
2. both position _and_ style given: closes the most recently opened window that matches _both_.
3. If style _or_ position are given: closes the most recently opened window that matches the given.


### Types `ACTIONS.close_last`
```lua
---@alias ACTIONS.close_last fun(
---     FLOAT:FLOAT,
---     opts: {
---         position_list:position_abrv[] | nil,
---         style:STYLE | nil,
---     },
--- ):boolean | nil
```

#### purpose
closes the most recently opened window, either by position or style.

### Types `ACTIONS.hide`
```lua
---@alias ACTIONS.hide fun(
---     FLOAT:FLOAT,
---     opts: {
---         bufwin_state:bufwin_state | nil,
---         pos:position_abrv | nil,
---         style_name:style_name | nil,
---     },
--- )
```

#### purpose
Hides a window either by position or state. 


### Types `ACTIONS.hide_last`
```lua
---@alias ACTIONS.hide_last fun(
---     FLOAT:FLOAT,
---     opts: {
---         position_list:position_abrv[] | nil,
---         style:STYLE | nil,
---     },
--- ):boolean | nil
```

#### purpose
hides a specific window, or the most recent one matching position or state.

Priorities:
1. Specific bufwin_state given.
2. both position _and_ style given: closes the most recently opened window that matches _both_.
3. If style _or_ position are given: closes the most recently opened window that matches the given.

