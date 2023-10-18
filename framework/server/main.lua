Framework = {}

Framework.Configuration = Config

Framework.Callbacks = {
    List = {},

    Register = function(name, cb)
        Framework.Callbacks.List[name] = cb
    end,

    Trigger = function(name, requestId, source, cb, ...)
        if Framework.Callbacks.List[name] then
            Framework.Callbacks.List[name](source, cb, ...)
        end
    end
}

RegisterServerEvent('peurost_lib:triggerServerCallback', function(name, requestId, ...)
    local playerId = source
    Framework.Callbacks.Trigger(name, requestId, playerId, function(...)
        TriggerClientEvent('peurost_lib:serverCallback', playerId, requestId, ...)
    end, ...)
end)

function GetFramework()
    return Framework
end

exports("GetFramework", GetFramework)