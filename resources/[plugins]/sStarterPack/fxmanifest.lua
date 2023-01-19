-- Version du 13/03/2022
fx_version "adamant"
lua54 "yes"
game "gta5"


client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/**/*.lua",
    "client/*.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "server/*.lua"
}

shared_scripts {
    "shared/*.lua"
}

escrow_ignore {
    "shared/*.lua"
}