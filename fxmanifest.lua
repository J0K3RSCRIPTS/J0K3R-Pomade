author 'J0K3R-Scripts <Discord: https://discord.gg/DH8tW6vSxV>'
description 'A free hair pomade script for RedM with VORP Core integration'
version '1.2.0'

fx_version 'adamant'
lua54 'on'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}


dependencies {
    'vorp_inventory',
}
