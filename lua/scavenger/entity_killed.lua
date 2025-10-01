local killed, killer, instigator = ...

if sqf.isNull(instigator) then
	instigator = sqf.UAVControl(sqf.Vehicle(killer))[1]
elseif sqf.isNull(instigator) then
	instigator = killer
end

if not sqf.isKindOf(killed, "CAManBase") then
	return
end

printf("%s was killed by %s", sqf.name(killed), sqf.name(instigator))

local function getLoadoutClasses(unit)
	local tab = {}
	local loadout = sqf.getUnitLoadout(unit)

	for i = 1, 9 do
		local class = loadout[i]
		class = istable(class) and class[1] or class

		if isstring(class) and #class > 1 then
			table.insert(tab, class)
		end
	end

	for _, class in pairs(loadout[10]) do -- Assigned items
		if #class > 1 then
			table.insert(tab, class)
		end
	end

	return tab
end

sqf.removeAllWeapons(killed)

-- Process loadout classes into data, return if nothing applicable is found (no weapons, ammo or supplies)

sqf.setVariable(killed, {"Scavenger_Data", getLoadoutClasses(killed)})

local holdActionID = sqf.call("BIS_fnc_holdActionAdd", {
	killed, "Scavenge",
	"\\a3\\missions_f_oldman\\data\\img\\holdactions\\holdAction_box_ca.paa",
	"\\a3\\missions_f_oldman\\data\\img\\holdactions\\holdAction_box_ca.paa",
	[[[_this, _target] luaExecute "Scavenger_Fnc_hold_check"]],
	[[_caller distance _target < 3;]],
	sqf.compile([[params ["_target", "_caller"]; _target setVariable ["Scavenger_Hold", getPlayerUID _caller, true];]]), -- Start
	nil, -- Progress
	sqf.compile([[params ["_target", "_caller"]; [_caller, _target] luaExecute "Scavenger_Fnc_completed"]]), -- Completion
	sqf.compile([[params ["_target"]; _target setVariable ["Scavenger_Hold", false, true];]]), -- Abort
	{}, -- Args
	4, -- Time
	0, -- Priority
	false, -- Remove on completion
	false -- Show while unconscious
})

local event = "Scavenger_" .. sqf.hashValue(killed)
local eventID

eventID = add_event_handler(event, function(unit)
	remove_event_handler(event, eventID)

	sqf.call("BIS_fnc_holdActionRemove", {
		unit, holdActionID
	})
end)
