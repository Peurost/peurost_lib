fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'peurost_lib - A cross-framework library meant to be used with PeuScripts resources | peurost.com'

client_scripts {
	'framework/client/main.lua',
    'framework/client/esx.lua',
    'framework/client/qb.lua',
    'utils/*.lua'
}

server_scripts {
	'framework/server/main.lua',
    'framework/server/esx.lua',
    'framework/server/qb.lua',
    'database/main.lua',
    --'@mysql-async/lib/MySQL.lua', --Uncomment this if you're using mysql-async
}

shared_scripts {
    'config.lua',
    'data/*.lua',
    '@ox_lib/init.lua', --Uncomment this if you're using ox_lib
}

lua54 'yes'