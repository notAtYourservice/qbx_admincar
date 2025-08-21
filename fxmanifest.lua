fx_version 'cerulean'
game 'gta5'

description 'Qbox Admin Car Command'
author 'Qbox Team'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

lua54 'yes'
