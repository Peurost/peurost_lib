function ProgressBar(label, time, options)
    if Config.ProgressBarResource == "qb" then
        local p = promise:new()
        QBCore.Functions.Progressbar("peurost_lib", label, time, options.useWhileDead, options.canCancel, {
            disableMovement = options.disableMovement,
            disableCarMovement = options.disableCarMovement,
            disableMouse = options.disableMouse,
            disableCombat = options.disableCombat,
            }, options.animation, {}, {}, function()
                p:resolve(true)
            end, function()
                p:resolve(false)
        end)

        return Citizen.Await(p)
    elseif Config.ProgressBarResource == "ox_lib" then
        local anim = false
        if options.animation then
            anim = {
                clip = options.animation.anim,
                dict = options.animation.animDict,
                flag = options.animation.flags
            }
        end

        return lib.progressBar({
            duration = time,
            label = label,
            useWhileDead = options.useWhileDead,
            canCancel = options.canCancel,
            disable = {
                car = options.disableCarMovement,
                move = options.disableMovement,
                mouse = options.disableMouse,
                combat = options.disableCombat,
            },
            anim = anim
        }) 
    end
end

exports("ProgressBar", ProgressBar)