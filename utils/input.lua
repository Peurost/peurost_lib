--[[
    Options [
        {
            title,
            name,
            type,
            isRequired,
            options [{
                value,
                label
            }]
        }
    ]
]]

function OpenInput(header, inputs)

    if Config.InputResource == "qb-input" then
        local fields = {}
        for _, v in ipairs(inputs) do
            table.insert(fields, {
                text = v.title,
                name = v.name,
                type = v.type,
                isRequired = v.isRequired or false,
                default = v.default,
                options = v.options or nil,
            })
        end
        return exports['qb-input']:ShowInput({
            header = header,
            submitText = "Confirm",
            inputs = fields,
        })
    elseif Config.InputResource == 'ox_lib' then
        local fields = {}
        for _, v in ipairs(inputs) do
            if v.type == "number" or v.type == "input" then
                table.insert(fields, {
                    type = v.type,
                    label = v.label,
                    default = v.default or nil,
                })
            elseif v.type == "checkbox" then
                table.insert(fields, {
                    type = 'checkbox',
                    label = v.label,
                    default = v.default or false,
                })
            elseif v.type == "select" then
                local options = {}
                for _, option in ipairs(v.options) do
                    table.insert(options, {value = option.value, label = option.text})
                end
                table.insert(fields, {
                    type = 'select',
                    label = v.label,
                    options = options,
                })
            end
        end
        local inputValues = lib.inputDialog(header, fields)
        local returnValues = {}
        for k, v in pairs(inputValues) do
            returnValues[inputs[k].name] = v
        end
        return returnValues
    end
end

exports("OpenInput", OpenInput)