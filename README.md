<div align = "center">
My highly personal floating window manager.
</div>

# Why I made this
First and foremost I want a floating window that *sticks around* while I'm doing other things, so I can have notes to look at, function signatures or definitions on screen, or even just a clear space to note down a shopping list before I forget.

# Usage

## Defaults

### Default User Commands
`setup_opts.dont_load_default_user_commands` is used to **skip** user commands, so if left nil, then defaults are loaded.
```lua
    if setup_opts.dont_load_default_user_commands then
```

### Default Keymaps
`setup_opts.dont_use_default_keymaps` is used to **skip** user commands, so if left nil, then defaults are loaded.
```lua
    if setup_opts.dont_use_default_keymaps then
```

# Styles & Positions

This module has 3 major components, two of which are designed for user extensions: Styles and Positions.

## Positions
Positions are functions that return a table with signature:
```lua
--- @alias Position_Return {
---     pos: position_abrv,
---     name_location:"footer" | "title",
---     config:vim.api.keyset.win_config,
--- }
```

An example is the "clock" I have briefly pop up on my screen:
```lua
--- @alias special_abrv
--- | 'clock'

--- @type ACTIONS.DRAW.FUNCTION
local clock = function()
    return {
        pos = "clock",
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
```

The reason that these are coded as functions that return tables rather than hard coded tables is to allow relative calculations on position and size to happen when the window is opened.

e.g.

```lua
    local col = math.floor(vim.o.columns * 0.275)
```

`position_abrv` is an extendable collection of strings:

```lua
--- @alias position_abrv
--- | corner_abrv
--- | exotic_abrv
--- | special_abrv

--- @alias corner_abrv
--- | 'tr'  # Top Right
--- | 'tl'  # Top Left
--- | 'br'  # Bottom Right
--- | 'bl'  # Bottom Left

--- @alias exotic_abrv
--- | 'tp'  # Top Pop-up -- small pop-up
--- | 'tb'  # Top Bar -- full bar across top
--- | 'bp'  # Bottom Pop-up -- small pop-up
--- | 'bb'  # Bottom Bar -- full bar across bottom
--- | 'cp'  # Center Pop-up -- small pop-up

--- @alias special_abrv
--- | 'cc'
```

When a new position is added it's abrv can be appended by duplicating the alias:

```lua
--- @alias special_abrv
```
this gives a warning, but allows types to be used without error, only if they are defined in the code. This is especially useful in `Styles` where a list of positions is needed, and can easily be typo'd.

## Styles

Styles are class like objects (as classes don't truly exist in lua which is tables all the way down) that have a collection of Methods and some hard coded values.

```lua
--- @alias STYLE {
--- name: style_name,
--- positions: position_abrv[],
--- is_not_scratch: true | nil,
--- ATTACH: (fun(
---             FLOAT:FLOAT,
---         ):nil),
--- setup: (fun(STATE:STATE)),
--- style: (fun(opts:{
---             state:STATE,
---             bufwin:bufwin,
---             conf_pos:config_and_position,
---             data:table, --- individual float styles define what their data looks like.
---         }):nil),
--- push: (fun(
---             STATE:STATE,
---             bufwin_pos:bufwin_pos,
---         ):nil),
--- pop: (fun(
---             STATE:STATE,
---             bufwin_state:bufwin_state,
---         ):nil),
--- }
```

`style_name` are simply strings that are extended as with `position_abrv`.
This is used in two major ways:
1. indexing in the data that the style stores in the global STATE object.
2. calling the specific style's methods when handling a floating window.

### style.positions

In a `STYLE` table, `positions` is a list of positions that can be used to open a window. They are checked in order to see if the global STATE object has an open window in that position and then if uses the first free (or opens in the 1st position in from the list if they are all occupied).

### style.ATTACH

This is called for each `STYLE` table when the module is loaded, it's main purpose is to allow the creation of `STATE[style_name] = {}` which is needed if the style needs some data from *before* entering the new window (e.g. old buffer's file-type) to decide what it's doing.


### STATE\[style_name\]
```lua
-- adds type support for this style's data.
--- @class STATE.style_data
--- @field duplicate? {
---     old_buf:integer,
---     bufwins : bufwin_pos[],
--- }
```

This is main goal is to store data for a *single* buffer *during* the creation process. If multiple buffers need data for a single style type then see `style.push` and `style.pop`.

### style.setup

This function is called right before a new window (or it's buffer) is opened, so data can be stored in `STATE[style_name]` and window configuration overrides can be calculated.

### style.style

This is the function that's called right after a window is opened (usually from inside the window) to allow for the *actual styling* to happen. E.g. setting file-type, inserting text, and so on.

### style.pop and style.push

These are largely ***not***-needed, indeed their `default` does nothing. They exist to allow individual styles to hold state for multiple windows. 

I.e. `style.push` could store a list of currently open windows of a type, allowing cycling through that list as the "in-focus" window.
`style.pop` is used to clean up this data when a window is closed.

-----------------------------------------------------------------------------------------------------------------------------------

<p>
This is currently in beta, as I am tweaking the details.
</p>


## Vim commands
In `opts.user_commands` there is a table structure that will be compiles into Vim commands accessible in the Command line, or in your own keymaps etc.

An excerpt from `command_defaults` is:
```lua
    scratch = {
        name = "FloatScratch",
        call_function = function(Float)
            return Float.toggle.scratch
        end,
        desc = "floating buffer",
    },
```


## Keymaps

In `opts.user_mappings` there is a table structure that will be compiles into keymaps, I like my mappings to be `<leader>h*>`, where * is a relevant letter, for things that just opens a [h]overing window, and `<leader><leader>*` for things that preform some action.

An excerpt from `mapping_defaults ` is:
```lua
    scratch = {
        modes = "n",
        keymap = "<leader>hf"
        call_function = function(Float)
            return Float.toggle.scratch
        end,
        desc = "[f]loating buffer",
    },
```

## Call Functions
Of note, the signature of the `call_function` function is:
```lua
--- @type fun(Float): fun(Float): {buf:integer, win:integer}
```

This is because it is initialised against a specific Float object when the command is created, but then the Float object still needs to be referenced when the command is executed to maintain state-fullness.

The function inside the `function(Float) ... end` is the "true" function that is intended to be used in the internal function calls etc. `Float:toggle(scratch)` but defining a `Float:function()` would need the `Float` object to be pre-loaded which limits what can be put into these functions; hence the wrapper,



