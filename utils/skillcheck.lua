local presets = {
    ox = {
        easy = {
            difficulty = "easy",
            amount = {min = 3, max = 5}
        },
        medium = {
            difficulty = "medium",
            amount = {min = 3, max = 5}
        },
        hard = {
            difficulty = "hard",
            amount = {min = 3, max = 5}
        },
    },
    qb = {
        easy = {
            duration = {min = 7500, max = 15000},
            pos = {min = 10, max = 30},
            width = {min = 10, max = 20},
            amount = {min = 3, max = 5}
        },
        medium = {
            duration = {min = 7500, max = 15000},
            pos = {min = 10, max = 30},
            width = {min = 10, max = 20},
            amount = {min = 3, max = 5}
        },
        hard = {
            duration = {min = 7500, max = 15000},
            pos = {min = 10, max = 30},
            width = {min = 10, max = 20},
            amount = {min = 3, max = 5}
        }
    }
}

function Skillcheck(difficulty)
    if Config.SkillcheckResource == "qb-skillbar" then
        local p = promise.new()
        local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
        local preset = presets.qb[difficulty]
        local attempts = math.random(preset.amount.min, preset.amount.max)
        local sAttempts = 0
        Skillbar.Start({
            duration = math.random(preset.duration.min, preset.duration.max),
            pos = math.random(preset.pos.min, preset.pos.max),
            width = math.random(preset.width.min, preset.width.max),
        }, function()
            if sAttempts + 1 >= attempts then
                p:resolve(true)
            else
                Skillbar.Repeat({
                    duration = math.random(preset.duration.min, preset.duration.max),
                    pos = math.random(preset.pos.min, preset.pos.max),
                    width = math.random(preset.width.min, preset.width.max),
                })
                sAttempts = sAttempts + 1
            end
        end, function()
            p:resolve(false)
        end)

        local pID = PlayerId()
        while p.state ~= 3 do
            DisableControlAction(0, 30, true) -- disable left/right
            DisableControlAction(0, 36, true) -- Left CTRL
            DisableControlAction(0, 31, true) -- disable forward/back
            DisableControlAction(0, 36, true) -- INPUT_DUCK
            DisableControlAction(0, 21, true) -- disable sprint
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle 
            DisablePlayerFiring(pID, true) -- Disable weapon firing
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(1, 37, true) -- disable weapon select
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            Citizen.Wait(1)
        end

        return Citizen.Await(p)
    elseif Config.SkillcheckResource == "ox_lib" then
        local checks = {}
        local amount = math.random(presets.ox[difficulty].amount.min, presets.ox[difficulty].amount.max)
        for i = 1, amount, 1 do
            checks[#checks+1] = presets.ox[difficulty].difficulty
        end
        return lib.skillCheck(checks)
    end
end

exports("Skillcheck", Skillcheck)