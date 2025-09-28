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

function AddAction(object, title, script, args, ...)
	local code = string.format([[params ["_target", "_caller", "_actionId", "_arguments"]; [_target, _caller, _actionId, _arguments] luaExecute "%s"]], script)

	return sqf.addAction(object, {title, code, args or {}, ...})
end

function EventHandler(object, name, script, parameterCount)
	local sqfParams, params = formatParameters(parameterCount)
	local code = string.format([[params [%s]; [%s] luaExecute "%s"]], sqfParams, params, script)

	return sqf.addEventHandler(object, {name, code})
end

function MissionEventHandler(name, script, parameterCount)
	local sqfParams, params = formatParameters(parameterCount)
	local code = string.format([[params [%s]; [%s] luaExecute "%s"]], sqfParams, params, script)

	return sqf.addMissionEventHandler({name, code})
end
