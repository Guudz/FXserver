fx_version "adamant"
game "gta5"
lua54 "yes"
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