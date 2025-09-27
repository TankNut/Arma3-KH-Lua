function printf(...)
	print(string.format(...))
end

local function formatParameters(count)
	local sqfParams = {}
	local params = {}

	for i = 1, count do
		local name = "_" .. i

		sqfParams[i] = '"' .. name .. '"'
		params[i] = name
	end

	return table.concat(sqfParams, ", "), table.concat(params, ", ")
end

function EventHandler(object, name, event, parameterCount)
	local sqfParams, params = formatParameters(parameterCount)

	sqf.addEventHandler(object, {name, string.format([[
		params [%s];
		[%s] luaExecute "LuaEvent_Fnc_%s"
	]], sqfParams, params, event)})
end

function MissionEventHandler(name, event, parameterCount)
	local sqfParams, params = formatParameters(parameterCount)

	sqf.addMissionEventHandler({name, string.format([[
		params [%s];
		[%s] luaExecute "LuaEvent_Fnc_%s"
	]], sqfParams, params, event)})
end
