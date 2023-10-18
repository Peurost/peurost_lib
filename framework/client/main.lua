Framework = {}

Framework.Callbacks = {}

Framework.Callbacks.ServerCallbacks = {}
Framework.Callbacks.CurrentRequestId = 0

Framework.Callbacks.Trigger = function(name, cb, ...)
	Framework.Callbacks.ServerCallbacks[Framework.Callbacks.CurrentRequestId] = cb
	TriggerServerEvent('peurost_lib:triggerServerCallback', name, Framework.Callbacks.CurrentRequestId, ...)

	if Framework.Callbacks.CurrentRequestId < 65535 then
		Framework.Callbacks.CurrentRequestId = Framework.Callbacks.CurrentRequestId + 1
	else
		Framework.Callbacks.CurrentRequestId = 0
	end
end

RegisterNetEvent('peurost_lib:serverCallback')
AddEventHandler('peurost_lib:serverCallback', function(requestId, ...)
	Framework.Callbacks.ServerCallbacks[requestId](...)
	Framework.Callbacks.ServerCallbacks[requestId] = nil
end)

RegisterNetEvent("peurost_lib:notify", function(title, desc, type)
	Framework.Notify(title, desc, type)
end)

RegisterNetEvent("peurost_lib:callCops", function(coords, reason)
	Framework.CallCops(coords, reason)
end)

function GetFramework()
    return Framework
end

exports("GetFramework", GetFramework)