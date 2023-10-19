if Config.Framework ~= "ESX" then return end

ESX = exports['es_extended']:getSharedObject()

Framework.GetPlayerIdentifier = function(source)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return nil end

    return Player.getIdentifier()
end

Framework.GetPlayerMoney = function(source, account)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return nil end

    return Player.getAccount(account)?.money
end

Framework.GivePlayerMoney = function(source, amount, account)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    Player.addAccountMoney(account, amount)
    return true
end

Framework.RemovePlayerMoney = function(source, amount, account)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    if Player.getAccount(account)?.money < amount then return false end

    Player.removeAccountMoney(account, amount)
    return true
end

Framework.PlayerHasItem = function(source, item, amount)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    local item = Player.getInventoryItem(item)

    if not item then return false end

    if not amount and item then return true end

    return amount <= item.count
end

Framework.GivePlayerItem = function(source, item, amount)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    if not Player.canCarryItem(item, amount) then return false end

    Player.addInventoryItem(item, amount)
    return true
end

Framework.RemovePlayerItem = function(source, item, amount)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    local itemData = Player.getInventoryItem(item)
    if not itemData or itemData.count < amount then return false end

    Player.removeInventoryItem(item, amount)
    return true
end

Framework.RegisterUsableItem = function(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

Framework.HasPlayerGroup = function(source, group)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end

    return group == Player.getGroup()
end

Framework.GetPlayerName = function(source)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return "NO_NAME" end
    return Player.getName()
end