-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

fx_version 'cerulean'
games {'gta5'}
lua54 "yes"

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
	'@qb-core/shared/locale.lua',
  	'locales/en.lua'
}