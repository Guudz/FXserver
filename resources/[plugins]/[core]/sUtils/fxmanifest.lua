
fx_version "adamant"

game "gta5"

client_scripts {
    -- RAGEUI
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    -- CONTEXTMENU LIBS
    "init/client/*.lua",
    "ronflexvente/**/client/*.lua",

}

server_scripts {
    "@async/async.lua",
    "@mysql-async/lib/MySQL.lua",
    --
    "init/server/*.lua",
    "ronflexvente/**/server/*.lua",
}

shared_scripts {
    "ronflexvente/**/shared/*.lua", 
}

exports {
    "GetVIP",
    "GetLevel"
}

server_exports {
    "GetVIP"
}


