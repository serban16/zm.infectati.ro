#include <amxmodx>

#define PLUGIN "Admin Free Look"
#define VERSION "2.0"
#define AUTHOR "Serbu"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
}

public client_putinserver(id)
{
    if (get_user_flags(id) & ADMIN_BAN)
    {
        server_cmd("mp_forcecamera 0",id);
    }
}  