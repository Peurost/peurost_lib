if Config.Framework ~= "QB" then return end

QBCore = exports['qb-core']:GetCoreObject()

Framework.GetPlayerIdentifier = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end

    return Player.PlayerData.citizenid
end

Framework.GetPlayerMoney = function(source, account)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end

    return Player.PlayerData.money[account]
end

Framework.GivePlayerMoney = function(source, amount, account)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    return Player.Functions.AddMoney(account, amount)
end
Framework.RemovePlayerMoney = function(source, amount, account)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    return Player.Functions.RemoveMoney(account, amount)
end

Framework.PlayerHasItem = function(source, item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local item = Player.Functions.GetItemByName(item)

    if not item then return false end

    if not amount and item then return true end

    return amount <= item.amount
end

Framework.GivePlayerItem = function(source, item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local addedItem = Player.Functions.AddItem(item, amount)
    if addedItem then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add", amount)
    end
    return addedItem
end

Framework.RemovePlayerItem = function(source, item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end

    local removedItem = Player.Functions.RemoveItem(item, amount)
    if removedItem then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove", amount)
    end
    return removedItem
end

Framework.RegisterUsableItem = function(item, cb)
    QBCore.Functions.CreateUseableItem(item, cb)
end

Framework.GetItemLabel = function(item)
    if not QBCore.Shared.Items[item] then return nil end
    return QBCore.Shared.Items[item].label
end

Framework.HasPlayerGroup = function(source, group)
    return QBCore.Functions.HasPermission(source, group)
end

Framework.GetPlayerName = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return "NO_NAME" end

    return Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname
end