#include <amxmodx> 
#include <fakemeta>
#include <amxmisc>

#define PLUGIN_NAME       "Function Infected" 
#define PLUGIN_VERSION    "1.0" 
#define PLUGIN_AUTHOR     "Serbu"

new g_identificare[][] = 
{
	"fullupdate", 
	"echo_off", 
	"gX4takingfire", 
	"echo_on", 
	"gX4sticktog", 
	"gX4regroup", 
	"gX4holdpos",
	"gX4getout"
}; 
new toggle_mode
new const g_reason[] = "Nu este permis sa iti schimbi numele."
new const g_name[] = "name"
new g_iTarget = 0

public plugin_init( ) 
{ 
    register_plugin( PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR )
	
    register_forward(FM_ClientUserInfoChanged, "fwClientUserInfoChanged")
    register_concmd("amx_nick", "cmdNick", ADMIN_SLAY, "<name or #userid> <new nick>")
    register_clcmd( "cl_setautobuy", "cmd_check" ) 
    register_clcmd( "cl_setrebuy", "cmd_check" ) 
	for(new i=0; i<sizeof g_identificare; i++)
	{
		register_clcmd(g_identificare[i], "cmdban")
	}

	toggle_mode = register_cvar("cfg_afc_mode", "1")
	

} 

public cmd_check( id ) 
{ 
    static arg[512], args, i 
    args = read_argc( ) 

    for( i = 1; i < args; ++i ) 
    { 
        read_argv( i, arg, charsmax( arg ) ) 
    } 

    return PLUGIN_CONTINUE 
}

public plugin_end()
{
   new szDir[] = "/", DirPointer, szFile[32];
   
   DirPointer = open_dir(szDir, "", 0);
   
   while(next_file(DirPointer, szFile, sizeof szFile - 1))
	{
      if(szFile[0] == '.')
         continue;
      
      if(containi(szFile, "custom.hpk") != -1)
	{
         delete_file(szFile);
         break;
	}
	}
   close_dir(DirPointer);
   return 1;
}
public cmdNick(id, level, cid)
{
    if (!cmd_access(id, level, cid, 3))
        return PLUGIN_HANDLED

    new arg1[32], arg2[32], authid[32], name[32], authid2[32], name2[32]

    read_argv(1, arg1, 31)
    read_argv(2, arg2, 31)

    new player = cmd_target(id, arg1, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF)

    if (!player)
        return PLUGIN_HANDLED

    get_user_authid(id, authid, 31)
    get_user_name(id, name, 31)
    get_user_authid(player, authid2, 31)
    get_user_name(player, name2, 31)

    g_iTarget = player
    set_user_info(player, "name", arg2)

    log_amx("Cmd: ^"%s<%d><%s><>^" change nick to ^"%s^" ^"%s<%d><%s><>^"", name, get_user_userid(id), authid, arg2, name2, get_user_userid(player), authid2)

    show_activity_key("ADMIN_NICK_1", "ADMIN_NICK_2", name, name2, arg2);

    console_print(id, "[AMXX] %L", id, "CHANGED_NICK", name2, arg2)

    return PLUGIN_HANDLED
}


public fwClientUserInfoChanged(id, buffer)
{
    if(!is_user_connected(id) || is_user_admin(id))
        return FMRES_IGNORED;

    static name[32], val[32]
    get_user_name(id, name, sizeof name - 1)
    engfunc(EngFunc_InfoKeyValue, buffer, g_name, val, sizeof val - 1)
    if(equal(val, name))
        return FMRES_IGNORED;

    if( g_iTarget != id )
    {
        engfunc(EngFunc_SetClientKeyValue, id, buffer, g_name, name)
        console_print(id, "%s", g_reason)
        return FMRES_SUPERCEDE;
    }
    g_iTarget = 0
    return FMRES_IGNORED
}
public cmdban(id)
{
	if (!is_user_connected(id))
	{
		return PLUGIN_HANDLED;
	}

	new name[32], userip[32];
	get_user_name(id, name, 31);
	get_user_ip(id, userip, 31, 1);

	new userid2 = get_user_userid(id);


	switch(get_pcvar_num(toggle_mode))
	{
		case 1:
		{
			server_cmd("kick #%d ^"Restrictionat pentrut FLOOD PERMANENT^"", userid2);
		}

		case 2:
		{
			server_cmd("kick #%d ^"Restrictionat pentru FLOOD PERMANENT^";wait;addip 0.0 ^"%s^";wait;writeip", userid2, userip);
		}

		case 3:
		{
			client_cmd(id, "wait;cl_timeout 0;wait;cl_dlmax 1;wait;quit")
		}
	}

	return PLUGIN_CONTINUE;
}