local args = {...}
local ply = args[1]

local origin = Vector(sqf.positionCameraToWorld({0, 0, 0}))
origin:AGLToASL()

local dir = Vector(sqf.getCameraViewDirection(ply))

local target = origin + (dir * 5000)
local trace = sqf.lineIntersectsSurfaces({origin, target, ply})[1]

if trace then
	local pos = Vector(trace[1])
	local normal = Vector(trace[2])
	local groundTrace = sqf.lineIntersectsSurfaces({pos + normal, pos + Vector(0, 0, -5000)})[1]

	sqf.setPosASL(ply, groundTrace[1])
else
	print("No position found to jump to!")
end
