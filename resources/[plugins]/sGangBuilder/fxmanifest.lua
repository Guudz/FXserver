-- Version du 04/06 à 00h23
fx_version "adamant"
lua54 "yes"
game "gta5"


client_scripts {
    "client/events.lua",

    "modules/**/client/*.lua",
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/**/*.lua",
    "client/*.lua",

}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "server/*.lua"
}


shared_scripts {
    "shared/config.lua"
}

escrow_ignore {
    "shared/config.lua"

}

