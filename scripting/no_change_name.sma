#include <amxmodx>
#include <fakemeta>
#include <amxmisc>

#define PLUGIN_NAME "No Name Change"
#define PLUGIN_VERSION "0.1"
#define PLUGIN_AUTHOR "VEN"

new const g_reason[] = "Nu este permis sa iti schimbi numele."
new const g_name[] = "name"
new g_iTarget = 0

public plugin_init()
{
    register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR)
    register_forward(FM_ClientUserInfoChanged, "fwClientUserInfoChanged")
    register_concmd("amx_nick", "cmdNick", ADMIN_SLAY, "<nume> <noul nume>")
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

public cmdChangeName( id , level , cid)
{
	if(!cmd_access( id , level , cid , 3))
		return PLUGIN_HANDLED;

	new szArgPlayer[26] , szArgName[36];
	read_argv(1 , szArgPlayer , 25);
	read_argv(2 , szArgName , 35);

	new tID = cmd_target( id , szArgPlayer , 11);

	if(!tID)
		return PLUGIN_HANDLED;

	new sztAuth[36];
	get_user_authid( tID , sztAuth , 35);

	nvault_set(g_Vault , sztAuth , szArgName);

	client_print(tID , print_chat , "[AMXX] An admin has changed your name!");

	stock_SetName(tID , szArgName);

	client_print(id , print_console , "[AMXX] You successfully changed their name.");
	
	return PLUGIN_HANDLED;
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

public client_connect(id)
{
	new name[32]
	get_user_name(id, name, 31)
	if(containi(name, "www") != -1 || containi(name, "WWW") != -1 || containi(name, "com") != -1 || containi(name, "player") != -1 || containi(name, "muie") != -1 || containi(name, "pula") != -1 || containi(name, "pizda") != -1 || containi(name, "ro") != -1)
	{
		kick(id)
		return
	}
}

public kick(id)
{
	server_cmd("kick #%d ^"Acest nume este restrictionat!^"", get_user_userid(id))
}