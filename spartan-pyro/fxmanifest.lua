fx_version("cerulean")
games({ "rdr3", "gta5" })

author("Spartan (@sprtan)")
description("Fireworks system")
version("1.0.0")

client_scripts({ "src/client/client.lua" })
server_scripts({ "src/server/server.lua", "src/server/configuration.lua" })
shared_scripts({ "@es_extended/imports.lua" })

data_file 'DLC_ITYP_REQUEST' 'stream/spartan_props.ytyp'
