--- BUG this returns nothing, but the init expects it to return an object that will be placed into Float.state **as** state,
--- TODO refactor init to simply call this as a setup
--- **OR** refactor this to return an object that can be injected in.

---Sets up the state for the FLOAT to be returned to the user from the *whole* module.
---@param FLOAT_TABLE FLOAT
local function setup(FLOAT_TABLE)
    for _, style_table in pairs(FLOAT_TABLE.style_tables) do
        style_table.ATTACH(FLOAT_TABLE)
    end
end

return setup
