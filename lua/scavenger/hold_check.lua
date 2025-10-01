local this, target = ...
local var = sqf.getVariable(target, {"Scavenger_Hold", false})

return sqf.distance(this, target) < 3 and (not var or var == sqf.getPlayerUID(this))
