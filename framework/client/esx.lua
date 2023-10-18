if Config.Framework ~= "ESX" then return end

ESX = exports['es_extended']:getSharedObject()

Framework.GetItemLabel = function(item)
    if not ItemLabels[item] then
        print("\n^1NO ITEM LABEL FOUND FOR "..item)
        return "NO_LABEL"
    end

    return ItemLabels[item]
end

Framework.Notify = function(title, desc, type)
    ESX.ShowNotification(title..": "..desc, type, 7000)
end

Framework.CallCops = function(coords, reason)
    --Your Dispatch code here
end