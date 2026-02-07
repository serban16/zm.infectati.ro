#include <amxmodx>
#include <amxmisc>

#if !defined charsmax
	#define charsmax(%1) sizeof(%1)-1
#endif

#define MAX_MEDIA 	30

new g_mediaID
new g_media_player[1536]
new g_media_names[MAX_MEDIA][32]
new g_media_urls[MAX_MEDIA][512]
new g_menuposition[33]
new g_currentmediaplaying[33]


enum INFO { NAME, AUTHOR, VERSION }

new const PLUGIN[INFO:3][] = 
{ 
	"Adv. Media Player", "cheap_suit", "3.1"
}

public plugin_init() 
{
	register_plugin(PLUGIN[NAME], PLUGIN[VERSION], PLUGIN[AUTHOR])
	register_cvar(PLUGIN[NAME], PLUGIN[VERSION], FCVAR_SPONLY|FCVAR_SERVER)
	register_menucmd(register_menuid("media_list"),  1023, "action_medialist")
	
	register_clcmd("say", 			"cmd_say")
	register_clcmd("say_team", 		"cmd_say")
	register_concmd("amx_addmedia", 	"cmd_addmedia", 	ADMIN_CFG, 	"- usage: <media name> <media url> | WARNING: BE SURE NOT TO HAVE A TYPO")
	register_concmd("amx_setmedia", 	"cmd_setmedia", 	ADMIN_BAN, 	"- usage: <@all|playerID> <media ID> | set media for player(s)")
	register_concmd("amx_reloadmedia", 	"cmd_reloadmedia", 	ADMIN_CFG,	"- reload's the amp_medialist.ini file")
	register_concmd("amx_listmedia", 	"cmd_listmedia", 	0, 		"- show's all media available also to get the media id for admins")
	register_concmd("amx_listeners", 	"cmd_showlisteners", 	0, 		"- show's current media playing")
	
	initialize()
}

public client_putinserver(id)
{
	g_currentmediaplaying[id] = -1
}


public cmd_reloadmedia(id, level, cid)
{
	if(!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED_MAIN
	
	initialize()
	console_print(id, "* Reloaded amp_medialist.ini file")
	
	return PLUGIN_HANDLED_MAIN
}

public cmd_listmedia(id)
{
	console_print(id, "* Available Media:")
	for(new i = 0; i < g_mediaID; i++)
		console_print(id, "#%d %s", i, g_media_names[i])
	
	return PLUGIN_HANDLED_MAIN
}

public cmd_showlisteners(id)
{
	
	console_print(id, "* Current media being played:")
	new players[32], num, i, index, mediaid
	get_players(players, num, "hc")
		
	for(i = 0; i < num; i++)
	{
		index = players[i]
		mediaid = g_currentmediaplaying[index]
		
		if(mediaid == -1)
			continue
		
		static name[32]
		get_user_name(index, name, charsmax(name))
		console_print(id, "%s  #%d. %s", name, mediaid, g_media_names[mediaid])
	}
	return PLUGIN_HANDLED_MAIN
}

public cmd_addmedia(id, level, cid)
{
	if(!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED_MAIN
	
	new medianame[32], mediaurl[256]
	read_argv(1, medianame, charsmax(medianame))
	read_argv(2, mediaurl, charsmax(mediaurl))
	
	copy(g_media_names[g_mediaID], charsmax(g_media_names[]), medianame)
	copy(g_media_urls[g_mediaID++], charsmax(g_media_urls[]), mediaurl)
	
	new configs_dir[128], file[128]
	get_localinfo("amxx_configsdir", configs_dir, charsmax(configs_dir))
	
	formatex(file, charsmax(file), "%s/%s", configs_dir, "amp_medialist.ini")
	if(file_exists(file))
	{
		new text[512]
		formatex(text, charsmax(text), "^n^"%s^" ^"%s^"", medianame, mediaurl)
		write_file(file, text)
		
		console_print(id, "* Added %s to amp_medialist.ini", medianame)
	}
	return PLUGIN_HANDLED_MAIN
}

public cmd_setmedia(id, level, cid)
{
	if(!cmd_access(id, level, cid, 3))
		return PLUGIN_HANDLED_MAIN
	
	new player[32], medianumber[11]
	read_argv(1, player, charsmax(player))
	read_argv(2, medianumber, charsmax(medianumber))
	
	new mediaid = str_to_num(medianumber)
	
	if(mediaid > g_mediaID)
	{
		console_print(id, "* Cant find media")
		return PLUGIN_HANDLED_MAIN
	}
		
	if(equali(player, "@all"))
	{	
		new players[32], num, i
		get_players(players, num, "hc")
		
		for(i = 0; i < num; i++)
			play_media(players[i], mediaid)
	}
	else
	{
		new index = cmd_target(id, player, 2)
		if(index) 
		{
			new name[32]
			get_user_name(index, name, charsmax(name))
			
			play_media(index, mediaid)
			client_print(id, print_console, "* Playing %s to %s", g_media_names[mediaid], name)
		}
	}
	return PLUGIN_HANDLED_MAIN
}

public cmd_say(id)
{
	static say_args[64]
	read_args(say_args, charsmax(say_args))
	remove_quotes(say_args)
	
	if(say_args[0] != '/')
		return PLUGIN_CONTINUE
	
	if(equali(say_args, "/play") || equali(say_args, "/muzica") || equali(say_args, "/radio") || equali(say_args, "/asculta"))
	{
		display_medialist(id, g_menuposition[id] = 0)
		return PLUGIN_HANDLED_MAIN
	}
		
	else if(equali(say_args, "/stopmuzica") || equali(say_args, "/stop") || equali(say_args, "/stopradio"))
	{
		g_currentmediaplaying[id] = -1
			
		static motd[1024], len
		len = formatex(motd, charsmax(motd), "<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><pre><body>")
		len += formatex(motd[len], charsmax(motd) - len, "<center>Radio a fost Oprit^n")
		len += formatex(motd[len], charsmax(motd) - len, "</body></pre></html>^n")
			
		show_motd(id, motd, PLUGIN[NAME])
			
		return PLUGIN_HANDLED_MAIN
	}
		
	else if(equali(say_args, "/playagain") || equali(say_args, "/reload") || equali(say_args, "/replay"))
	{
		if(g_currentmediaplaying[id] == -1)
			client_print(id, print_chat, "* You are not listening to any media.")
		else
			play_media(id, g_currentmediaplaying[id])
			
		return PLUGIN_HANDLED_MAIN
	}
	return PLUGIN_CONTINUE
}

display_medialist(id, pos)
{
	if(pos < 0)
		return
	
	new maxtotal = g_mediaID

	new start = pos * 8
  	if(start >= maxtotal)
    		start = pos = g_menuposition[id]
	
	new menubody[512]
  	new len = format(menubody, charsmax(menubody), "Selecteaza postul:^n^n")
	
  	new end = start + 8
  	new keys = MENU_KEY_0

	if(end > maxtotal)
    		end = maxtotal

	new b = 0
  	for(new a = start; a < end; ++a) 
	{
		keys |= (1<<b)
		len += formatex(menubody[len], charsmax(menubody), "%d. %s^n", ++b, g_media_names[a])
  	}

  	if(end != maxtotal)
	{
    		formatex(menubody[len], charsmax(menubody), "^n9. %s...^n0. %s", "Mai mult", pos ? "Inapoi" : "Iesire")
    		keys |= MENU_KEY_9
  	}
  	else
		formatex(menubody[len], charsmax(menubody), "^n0. %s", pos ? "Inapoi" : "Iesire")
		
  	show_menu(id, keys, menubody, -1, "media_list")
}

public action_medialist(id, key)
{
	switch(key)
	{
    		case 8: display_medialist(id, ++g_menuposition[id])
		case 9: display_medialist(id, --g_menuposition[id])
    		default:play_media(id, (g_menuposition[id] * 8 + key))
	}
	return PLUGIN_HANDLED
}

play_media(id, media_id)
{
	if(!file_exists(g_media_player))
		return
	
	g_currentmediaplaying[id] = media_id
	
	new player[sizeof(g_media_player)], motd[sizeof(g_media_player)], line, length
	while(read_file(g_media_player, line++, player, charsmax(player), length))
		add(motd, charsmax(motd), player)

	replace_all(motd, charsmax(motd), "[MEDIA_NAME]", g_media_names[media_id])
	replace_all(motd, charsmax(motd), "[MEDIA_URL]", g_media_urls[media_id])
	
	show_motd(id, motd, PLUGIN[NAME])
}

initialize()
{
	new configs_dir[128], file[128], file_text[2048], len = 0; g_mediaID = 0
	get_localinfo("amxx_configsdir", configs_dir, charsmax(configs_dir))
	
	formatex(file, charsmax(file), "%s/%s", configs_dir, "amp_medialist.ini")
	if(!file_exists(file))
	{
		len = format(file_text, charsmax(file_text), "; %s Media List^n", PLUGIN[NAME])
		len += format(file_text[len], charsmax(file_text) - len, "; Format: ^"Media Name^"  ^"Media URL^"^n")
		len += format(file_text[len], charsmax(file_text) - len, "; eg. ^"Papa Roach - Last Resort^" ^"www.mysite.com/lastresort.mp3^n^"")	
		write_file(file, file_text)
	}
	
	
	formatex(g_media_player, charsmax(g_media_player), "%s/%s", configs_dir, "amp_player.html"); len = 0
	if(!file_exists(g_media_player))
	{
		len = formatex(file_text, charsmax(file_text), "<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><pre><body>")
		len += formatex(file_text[len], charsmax(file_text) - len, "<center><b>Media:</b>[MEDIA_NAME]^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<center>Apasa OK pentru a continua sa joci.^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<center><OBJECT ID=^"MediaPlayer1^" width=400 height=144^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "classid=^"CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "CODEBASE=^"http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,5,715^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "standby=^"Loading Microsoft® Windows® Media Player components...^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "type=^"application/x-oleobject^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<PARAM NAME=^"AutoStart^" VALUE=^"True^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<PARAM NAME=^"FileName^" VALUE=^"[MEDIA_URL]^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<PARAM NAME=^"ShowControls^" VALUE=^"True^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<PARAM NAME=^"ShowStatusBar^" VALUE=^"False^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<PARAM NAME=^"AutoRewind^" VALUE=^"True^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "<EMBED type=^"application/x-mplayer2^" pluginspage=^"http://www.microsoft.com/Windows/MediaPlayer/^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "SRC=^"[MEDIA_URL]^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "name=^"MediaPlayer1^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "autostart=1^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "showcontrols=1^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "autorewind=^"True^"^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "showstatusbar=^"False^">^n")
		len += formatex(file_text[len], charsmax(file_text) - len, "</EMBED></OBJECT></body></pre></html>^n")
		
		write_file(g_media_player, file_text)
	}
	
	new text[1024], line, length
	while(read_file(file, line++, text, charsmax(text), length))
	{
		trim(text)
		if(!length || text[0] == ';')
			continue
		
		if(g_mediaID >= MAX_MEDIA)
			break
	
		static left[32], right[512]
		strbreak(text, left, charsmax(left), right, charsmax(right))
		
		replace_all(left, charsmax(left), "^"", "")
		replace_all(right, charsmax(right), "^"", "")
		replace_all(right, charsmax(right), " ", "%20")
		
		copy(g_media_names[g_mediaID], charsmax(g_media_names[]), left)
		copy(g_media_urls[g_mediaID++], charsmax(g_media_urls[]), right)
	}
}