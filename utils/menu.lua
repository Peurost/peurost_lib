--[[
    Options [
        {
            title
            description
            icon
            disabled
            hidden
            isServer
            event
            args
        }
    ]
]]

function OpenMenu(title, options)
    local menu = {}

    if Config.MenuResource == "qb-menu" then
        menu[#menu + 1] = {
            header = title,
            isMenuHeader = true
        }
    end

    for k, v in pairs(options) do
        if Config.MenuResource == "qb-menu" then
            menu[#menu + 1] = {
                header = v.title,
                txt = v.description or nil,
                icon = v.icon or false,
                disabled = v.disabled or false,
                hidden = v.hidden or false,
                params = {
                    isServer = v.isServer or nil,
                    event = v.event or nil,
                    args = v.args or nil
                }
            }
        elseif Config.MenuResource == "ox_lib" then
            if not v.hidden then
                if v.isServer then
                    menu[#menu + 1] = {
                        title = v.title,
                        description = v.description or nil,
                        icon = v.icon or false,
                        serverEvent = v.event or nil,
                        args = v.args or nil,
                        disabled = v.disabled or false,
                    }
                else
                    menu[#menu + 1] = {
                        title = v.title,
                        description = v.description or nil,
                        icon = v.icon or false,
                        event = v.event or nil,
                        args = v.args or nil,
                        disabled = v.disabled or false,
                    }
                end
            end
        end
    end

    if Config.MenuResource == "qb-menu" then
        exports['qb-menu']:openMenu(menu)
    elseif Config.MenuResource == "ox_lib" then
        lib.registerContext({id = "peulib", title = title, onExit = OnMenuClose, options = menu})
        lib.showContext('peulib')
    end
end

exports("OpenMenu", OpenMenu)

function OnMenuClose()
    TriggerEvent("peurost_lib:closedMenu")
end

RegisterNetEvent("qb-menu:client:menuClosed", OnMenuClose)