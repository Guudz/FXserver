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
    
    "modules/**/client/*.lua",
    "players/**/client/*.lua",
    "players/**/shared/*.lua"
}

server_scripts {
    "@async/async.lua",
    "@mysql-async/lib/MySQL.lua",
    "modules/**/server/*.lua",
    "players/**/server/*.lua",
    "players/**/shared/*.lua"
}
