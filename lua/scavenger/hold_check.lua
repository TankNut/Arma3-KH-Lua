local args = {...}
local this, target = args[1], args[2]
local var = sqf.getVariable(target, {"Scavenger_Hold", false})

return sqf.distance(this, target) < 3 and (not var or var == sqf.getPlayerUID(this))
