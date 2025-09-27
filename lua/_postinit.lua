local ply = sqf.player()

AddAction(ply, "Jump", "jump")

EventHandler(ply, "InventoryOpened", "inventory_opened", 3)
MissionEventHandler("EntityKilled", "entity_killed", 3)
