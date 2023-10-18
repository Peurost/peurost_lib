if Config.Framework ~= "QB" then return end

QBCore = exports['qb-core']:GetCoreObject()

Framework.GetItemLabel = function(item)
    if not QBCore.Shared.Items[item] then return nil end
    return QBCore.Shared.Items[item].label
end

Framework.Notify = function(title, desc, type)
    QBCore.Functions.Notify({text = desc, caption = title}, type, 10000)
end

Framework.CallCops = function(coords, reason)
    TriggerServerEvent('police:server:policeAlert', reason)
end