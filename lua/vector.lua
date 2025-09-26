VECTOR = {}

function isvector(var)
	return istable(var) and getmetatable(var) == VECTOR
end

-- Metamethods

local lookup = {
	x = 1,
	y = 2,
	z = 3
}

function VECTOR:__index(key)
	local index = lookup[key]

	if index then
		return self[index]
	end

	return rawget(VECTOR, key)
end

function VECTOR:__newindex(key, val)
	local index = lookup[key]

	if index then
		rawset(self, index, val)
	end
end

function VECTOR.__add(a, b) return Vector(a[1] + b[1], a[2] + b[2], a[3] + b[3]) end
function VECTOR.__sub(a, b) return Vector(a[1] - b[1], a[2] - b[2], a[3] - b[3]) end

function VECTOR.__mul(a, b) return isnumber(b) and Vector(a[1] * b, a[2] * b, a[3] * b) or Vector(a[1] * b[1], a[2] * b[2], a[3] * b[3]) end
function VECTOR.__div(a, b) return isnumber(b) and Vector(a[1] / b, a[2] / b, a[3] / b) or Vector(a[1] / b[1], a[2] / b[2], a[3] / b[3]) end

function VECTOR:__unm() return Vector(-self[1], -self[2], -self[3]) end

-- Functions

local function copy(from, to)
	to[1] = from[1]
	to[2] = from[2]
	to[3] = from[3]
end

function VECTOR:AGLToASL() copy(sqf.AGLToASL(self), self) end
function VECTOR:ASLToATL() copy(sqf.ASLToATL(self), self) end

-- Constructor

function Vector(x, y, z)
	local vec

	if istable(x) then
		vec = {x[1] or 0, x[2] or 0, x[3] or 0}
	else
		vec = {x or 0, y or 0, z or 0}
	end

	return setmetatable(vec, VECTOR)
end
