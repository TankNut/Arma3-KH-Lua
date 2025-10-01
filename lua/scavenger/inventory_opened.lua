local _, primary, _ = ...

if sqf.isKindOf(primary, "CAManBase") and not sqf.alive(primary) then
	return true
end
