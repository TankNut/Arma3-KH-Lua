local args = {...}
local choice = table.remove(args, 1)

local options = {}
-- options["Scavenger_HoldAction_Check"] = function(this, target)
-- 	local var = sqf.getVariable(target, {"Scavenger_Hold", false})

-- 	return sqf.distance(this, target) < 3 and (not var or var == sqf.getPlayerUID(this))
-- end

local func = options[choice]

if func then
	return func(unpack(args))
end
