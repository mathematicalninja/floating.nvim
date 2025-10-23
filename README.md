<div align = "center">
My highly personal floating window manager.
</div>

# Why I made this
First and foremost I want a floating window that *sticks around* while I'm doing other things, so I can have notes to look at, function signatures or definitions on screen, or even just a clear space to note down a shopping list before I forget.


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



