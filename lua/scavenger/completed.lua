local caller, target = ...

printf("%s has finished looting %s", sqf.name(caller), sqf.name(target))

EmitEvent("Scavenger_" .. sqf.hashValue(target), target, "GLOBAL")

local loadout = sqf.getVariable(target, "Scavenger_Data")

for _, class in ipairs(loadout) do
	print("Class: ", class)
end
