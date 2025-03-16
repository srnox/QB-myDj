fx_version "cerulean"
game "gta5"

description 'Baspel DJ System (QBCore Version)'
version '1.0.0'

lua54 'yes'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'xsound'
}