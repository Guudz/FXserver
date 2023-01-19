fx_version "cerulean"

game "gta5"

description "Jail RageUIV2"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua',
    "server/sv_config.lua"
}

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
	'client/client.lua',
    "client/config.lua",
}