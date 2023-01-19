fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server.lua',
}