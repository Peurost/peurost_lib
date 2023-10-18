Database = {}
Database.IsLoading = true

if Config.DatabaseResource == "oxmysql" then
    Database = {
        FetchSync = function(query, params)
            return exports.oxmysql:executeSync(query, params)
        end,
    
        ExecuteSync = function(query, params)
            return exports.oxmysql:executeSync(query, params)
        end,
    
        Insert = function(query, params, callback)
            exports.oxmysql:insert(query, params, callback)
        end,
        Execute = function(query, params, callback)
            exports.oxmysql:execute(query, params, callback)
        end
    }
elseif Config.DatabaseResource == "mysql-async" then
    Database = {
        FetchSync = function(query, params)
            return MySQL.Sync.fetchAll(query, params)
        end,
        ExecuteSync = function(query, params)
            return MySQL.Sync.execute(query, params)
        end,
        Insert = function(query, params, callback)
            MySQL.Async.insert(query, params, callback)
        end,
        Execute = function(query, params, callback)
            MySQL.Async.execute(query, params, callback)
        end
    }
end

function GetDatabase()
    while Database.IsLoading do
        Citizen.Wait(100)
    end
    return Database
end

exports("GetDatabase", GetDatabase)