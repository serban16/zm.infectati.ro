/* Amx Mod X Script

	One Name Plugin
	
	By: Suicid3
----------------------------------------------------

Commands:
	amx_changename <authid, nick or #userid> <new name>	- forces name change.
	amx_allownamechange <authid, nick or #userid>		- allows player to change their name.
	
----------------------------------------------------

Functionality:
	On players first time in server. It displays a Menu saying you have 1 minute to change your name.
	After 1 minute it logs name and they need admins permission to change their name.

----------------------------------------------------

Credits:
	wepainters   - His idea.

----------------------------------------------------

Build Log:
	1.0  -  Initial attempt.
	1.1  -  Fixed errors in first attempt
	1.2  -  More bug fixes.
	2.0  -  Started plugin from scratch using a new method making plugin more stable
	2.1  -  Fixed small glitch in system.
	2.2  -  Added Bot ignorance.
	3.0  -  Redo! - fix bugs that appeared out of no where!!!
*/

#include <amxmodx>
#include <amxmisc>
#include <nVault>

#define ADMIN_LEVEL	ADMIN_KICK
#define PLUGIN_VER	"3.0"

new g_Vault;
new g_szMotd[101]

new bool:g_bAllowed[33];
new bool:g_bFirst[33];

new gabenstamp;

public plugin_init()
{
	register_plugin("One Name" , PLUGIN_VER , "Suicid3");

	register_concmd("amx_changename" , "cmdChangeName" , ADMIN_LEVEL , "<player> <new name> - forces perm name change");
	register_concmd("amx_allownamechange" , "cmdAllowChange" , ADMIN_LEVEL , "<player> - allows player to change their name");

	register_clcmd("say /name","ShowHelp");
	register_clcmd("say_team /name","ShowHelp");

	register_menucmd( register_menuid("\yName Warning:") , 1023 , "Menudone");

	register_event("ResetHUD","eventReset", "be");

	g_Vault = nvault_open("uno-namo");

	if(g_Vault < 0)
		log_amx("[One Name] Vault Could not Open! Plugin wont be used this time.");

	get_configsdir(g_szMotd , 100);
	format(g_szMotd , 100 , "%s/One_Name.htm" , g_szMotd);
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

public cmdAllowChange( id , level , cid)
{
	if(!cmd_access( id , level , cid , 2))
		return PLUGIN_HANDLED;

	new szArgPlayer[26];
	read_argv(1 , szArgPlayer , 25);

	new tID = cmd_target( id , szArgPlayer , 11);

	if(!tID)
		return PLUGIN_HANDLED;

	g_bAllowed[tID] = true;

	client_print(tID , print_chat , "[AMXX] An admin has allows YOU to changed your name! You have 60 seconds.");
	client_print(id , print_console , "[AMXX] You successfully allowed them to changed their name.");

	set_task(60.0 , "stock_TimesUp" , tID)

	return PLUGIN_HANDLED;
}

public client_putinserver(id)
{
	if(g_Vault < 0)
		return PLUGIN_CONTINUE;

	new szCurrName[36] , szAuth[36] , szSavedName[36];
	get_user_name(id ,szCurrName , 35);
	get_user_authid( id , szAuth , 35);
	if(!nvault_lookup(g_Vault , szAuth , szSavedName , 35 , gabenstamp))
		g_bFirst[id] = true;
	else
		if(!equali(szCurrName , szSavedName))
			stock_SetName(id , szSavedName );

	return PLUGIN_CONTINUE;
}

public client_infochanged(id)
{
	if(g_Vault < 0)
		return PLUGIN_CONTINUE;

	if(g_bAllowed[id] || is_user_bot(id))
		return PLUGIN_CONTINUE;

	new szNewName[36] , szSavedName[36] , szAuth[36];
	get_user_info(id , "name" , szNewName , 35)
	get_user_authid( id , szAuth , 35);
	if(!nvault_lookup(g_Vault , szAuth , szSavedName , 35 , gabenstamp))
	{
		return PLUGIN_CONTINUE;
	}

	if(!equali(szNewName , szSavedName))
	{
		stock_SetName(id , szSavedName);
		client_print(id , print_chat , "[AMXX] Sorry but you are only allowed to use one name here.");
		return PLUGIN_HANDLED;
	}
	return PLUGIN_CONTINUE;
}

public eventReset(id)
{
	if(is_user_bot(id))
		return PLUGIN_CONTINUE;

	if(g_bFirst[id])
	{
		g_bFirst[id] = false;
		set_task(65.0,"stock_TimesUp",id);
		DisplayWarning(id);
	}

	return PLUGIN_CONTINUE;
}

stock stock_SetName( id , szName[])
{
	client_cmd(id , "name ^"%s^"" , szName);
	client_cmd(id , "setinfo name ^"%s^"" , szName);
}

public stock_TimesUp(id)
{
	g_bAllowed[id] = false;
	new szName[36] , szAuth[36];
	get_user_name(id , szName , 35);
	get_user_authid(id, szAuth, 35);
	client_print( id , print_chat , "[AMXX] Times up! Your name on this server is now ^"%s^". Say /name for more info.", szName);
	nvault_set(g_Vault , szAuth , szName);	
}

public DisplayWarning( id )
{
	new Msg[256],len,Keys;
	Keys = (1<<3);

	len = format(Msg,255,"\yName Warning:^n");
	len += format(Msg[len],255-len,"\wThis is your official warning. You have \r1 minute\w^n");
	len += format(Msg[len],255-len,"to change your name to what you want to keep it^n");
	len += format(Msg[len],255-len,"for this server. The server logs your name and wont^n");
	len += format(Msg[len],255-len,"let you change it after \r1 minute\w from now.^n");
	len += format(Msg[len],255-len,"Press (4) to Continue.");

	show_menu(id,Keys,Msg,-1);
	return PLUGIN_CONTINUE;
}

public Menudone()
{
	return PLUGIN_CONTINUE
}

public ShowHelp(id)
{
	show_motd(id , g_szMotd , "One Name Help:");
	return PLUGIN_HANDLED;
}