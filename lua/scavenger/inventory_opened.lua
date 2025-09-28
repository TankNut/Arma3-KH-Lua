local args = {...}
local _, primary, _ = args[1], args[2], args[3]

if sqf.isKindOf(primary, "Man") and not sqf.alive(primary) then
	return true
end
