#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Kick Schimbare Nume"
#define VERSION "1.0"
#define AUTHOR "INFECTATI.RO"

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
}

public changename(id)
{
	server_cmd("kick #%d ^"%s^"", get_user_userid(id), "Kick pentru schimbare nume.");
}