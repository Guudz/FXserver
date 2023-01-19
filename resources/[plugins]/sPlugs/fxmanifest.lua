-- Manifest Version
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

--Speedometer

-- UI
ui_page "player/speedometer/ui/index.html"
files {
	"player/speedometer/ui/index.html",
	"player/speedometer/ui/assets/clignotant-droite.svg",
	"player/speedometer/ui/assets/clignotant-gauche.svg",
	"player/speedometer/ui/assets/feu-position.svg",
	"player/speedometer/ui/assets/feu-route.svg",
	"player/speedometer/ui/assets/fuel.svg",
	"player/speedometer/ui/fonts/fonts/DS-DIGIT.TTF",
	"player/speedometer/ui/script.js",
	"player/speedometer/ui/style.css",
	"player/speedometer/ui/debounce.min.js"
}

-- Client Scripts
client_scripts {
	"player/speedometer/client.lua",
}

--- Dpemotes --- 

client_scripts {
	'player/dpemotes/NativeUI.lua',
	'player/dpemotes/Config.lua',
	'player/dpemotes/Client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'player/dpemotes/Config.lua',
	'player/dpemotes/Server/*.lua'
}

--- /Porter ---

client_script('player/PiggyBack/client/main.lua')
server_script('player/PiggyBack/server/main.lua')

--- esx-qalle-jail ---

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"player/esx-qalle-jail/config.lua",
	"player/esx-qalle-jail/server/server.lua"
}

client_scripts {
	"player/esx-qalle-jail/config.lua",
	"player/esx-qalle-jail/client/utils.lua",
	"player/esx-qalle-jail/client/client.lua"
}

dependency('es_extended')


client_script 'lystyac.lua'