fx_version "adamant"

game "gta5"

client_scripts {
    -- RAGEUI
    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
    "src/client/menu/windows/*.lua",
    -- CONTEXTMENU LIBS
    "ContextUI/components/*.lua",
    "ContextUI/ContextUI.lua",
    -- RAGEUI
    "init/shared/init.lua",
    "init/client/cl_init.lua",
    "init/client/eUtis.lua",
    "players/clo/client/*.lua",
    "init/client/cl_initESX.lua",
    "markers.lua",
    "blips.lua",
    "functions/client.lua",
    "functions/cl_cayo.lua",
    "functions/cayo_perico.lua",
    "functions/cl_weapons-on-back.lua",
    "functions/veyzo_server.lua",
    "player/creator/client/*.lua",
    "ContextMenu.lua",
    'players/**/shared/*.lua',
    'players/**/client/*.lua',
    'jobs/**/shared/*.lua',
    'jobs/**/client/*.lua',
    'jobs/mecano/config.lua',
    "jobs/custom/cfg_custom.lua",
    "jobs/custom/functions.lua",
    "jobs/custom/client/main.lua",
    'jobs/menu.lua',
}

server_scripts {
    "@async/async.lua",
    "@mysql-async/lib/MySQL.lua",
    "init/shared/init.lua",
    "init/server/sv_init.lua",
    "init/server/eUtils.lua",
    "jobs/custom/server/main.lua",
    "init/server/sv_initESX.lua",
    "players/clo/server/*.lua",
    'players/**/shared/*.lua',
    'players/**/server/*.lua',
    'jobs/**/shared/*.lua',
    "player/creator/server/*.lua",
    "players/vêtements/server/*.lua",
    'jobs/**/server/*.lua',
    "maintenance.lua",
    "players/banSQL.lua",
}

exports {
    "GetVIP",
    "GetLevel",
    "VerifyToken",
}

server_exports {
    "GetVIP",
    "GetLevel",
    "VerifyToken",
}

files {
    'html/index.html',
    'html/music.mp3',
    'html/css/fontawesome-all.min.css',
    'html/css/plugins.min.css',
    'html/css/bootstrap.css',
    'html/css/style.css',
    'html/img/*.jpg',
    'html/img/background/slide2-bg.jpg',
    'html/img/background/slide3-bg.jpg',
    'html/js/plugins-savage.js',
    'html/js/plugins.js',
    'html/js/savage.min.js',
    'html/js/yt.js',
    'html/js/jquery.ajaxchimp.js',
    'html/js/jquery.backstretch.min.js',
    'html/js/jquery-1.11.0.min.js',
    'html/js/lj-safety-first.js',
    'html/js/music.js',
    'html/js/owl.carousel.min.js',
    'html/webfonts/fa-brands-400.eot',
    'html/webfonts/fa-brands-400.svg',
    'html/webfonts/fa-brands-400.ttf',
    'html/webfonts/fa-brands-400.woff',
    'html/webfonts/fa-brands-400.woff2',
    'html/webfonts/fa-light-300.eot',
    'html/webfonts/fa-light-300.svg',
    'html/webfonts/fa-light-300.ttf',
    'html/webfonts/fa-light-300.woff',
    'html/webfonts/fa-light-300.woff2',
    'html/webfonts/fa-regular-400.eot',
    'html/webfonts/fa-regular-400.svg',
    'html/webfonts/fa-regular-400.ttf',
    'html/webfonts/fa-regular-400.woff',
    'html/webfonts/fa-regular-400.woff2',
    'html/webfonts/fa-solid-900.eot',
    'html/webfonts/fa-solid-900.svg',
    'html/webfonts/fa-solid-900.ttf',
    'html/webfonts/fa-solid-900.woff',
    'html/webfonts/fa-solid-900.woff2',
}

loadscreen 'html/index.html'

ui_page "players/speedometer/angular/dist/index.html"
