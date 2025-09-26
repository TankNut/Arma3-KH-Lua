local args = {...}
local killed, killer, instigator = args[1], args[2], args[3]

if sqf.isNull(instigator) then
	instigator = sqf.UAVControl(sqf.Vehicle(killer))[1]
elseif sqf.isNull(instigator) then
	instigator = killer
end

printf("%s was killed by %s", sqf.name(killed), sqf.name(instigator))

sqf.lockInventory(killed, true)
