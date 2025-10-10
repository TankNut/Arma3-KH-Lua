gameEvent.add({"ENTITY", sqf.player()}, "InventoryOpened", function(_, primary, _)
	if sqf.isKindOf(primary, "CAManBase") and not sqf.alive(primary) then
		return true
	end
end)

gameEvent.add("MISSION", "EntityKilled", Scavenger_Entity_Killed)
