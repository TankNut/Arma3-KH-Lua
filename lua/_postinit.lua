function printf(...)
	sqf.systemChat(string.format(...))
end

local ply = sqf.player()

sqf.addAction(ply, {"Jump", [[
	params ["_target"];
	[_target] luaExecute "LuaAction_Fnc_jump"
]]})

EventHandler(ply, "InventoryOpened", "inventory_opened", 3)
MissionEventHandler("EntityKilled", "entity_killed", 3)
