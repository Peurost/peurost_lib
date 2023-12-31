Target = {}

if Config.TargetResource == "qb-target" then
    Target = {
        AddEntity = function(entities, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    action = v.onSelect
                }
            end
            exports["qb-target"]:AddTargetEntity(entities, {
                options = tOptions,
                distance = distance
            })
        end,
        AddBone = function(bones, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    action = v.onSelect
                }
            end
            exports["qb-target"]:AddTargetBone(bones, {
                options = tOptions,
                distance = distance
            })
        end,
        AddModel = function(models, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    action = v.onSelect
                }
            end
            exports['qb-target']:AddTargetModel(models, {
                options = tOptions,
                distance = distance
            })
        end,
        AddBoxZone = function(boxData, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    action = v.onSelect
                }
            end
            exports['qb-target']:AddBoxZone(boxData.name, boxData.coords, boxData.size.x, boxData.size.y, {
                name = boxData.name,
                heading = boxData.heading,
                debugPoly = Config.Debug,
                minZ = boxData.coords.z,
                maxZ = boxData.coords.z + boxData.size.z
            }, {
                options = tOptions,
                distance = distance
            })
        end,
        RemoveZone = function(id)
            exports['qb-target']:RemoveZone(id)
        end
    }
elseif Config.TargetResource == "ox_target" then
    function TransformOnSelect(callback)
        return function(data)
            callback(data?.entity)
        end
    end

    Target = {
        AddEntity = function(entities, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    onSelect = TransformOnSelect(v.onSelect),
                    distance = distance
                }
            end
            exports.ox_target:addLocalEntity(entities, tOptions)
        end,
        AddBone = function(bones, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    onSelect = TransformOnSelect(v.onSelect),
                    bones = bones,
                    distance = distance
                }
            end
            exports.ox_target:addGlobalVehicle(tOptions)
        end,
        AddModel = function(models, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    onSelect = TransformOnSelect(v.onSelect),
                    distance = distance
                }
            end
            exports.ox_target:addModel(models, tOptions)
        end,
        AddBoxZone = function(boxData, options, distance)
            local tOptions = {}
            for k, v in pairs(options) do
                tOptions[#tOptions + 1] = {
                    icon = v.icon,
                    label = v.label,
                    canInteract = v.canInteract,
                    onSelect = TransformOnSelect(v.onSelect),
                    distance = distance
                }
            end
            exports.ox_target:addBoxZone({
                name = boxData.name,
                coords = boxData.coords,
                size = boxData.size,
                rotation = boxData.heading,
                options = tOptions,
                debug = Config.Debug,
                drawSprite = Config.Debug
            })
        end,
        RemoveZone = function(id)
            exports.ox_target:removeZone(id)
        end,
    }
end

function GetTarget()
    if not Config.TargetResource then return false end
    return Target
end

exports("Target", GetTarget)