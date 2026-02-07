#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <alt_chat>

#define SELECTMAPS  5
#define charsof(%1) (sizeof(%1)-1)

new Array:g_mapName;
new g_mapNums, g_nextName[SELECTMAPS];
new g_voteCount[SELECTMAPS + 2];
new g_mapVoteNum, g_teamScore[2], g_lastMap[32], g_coloredMenus;
new bool:g_selected = false;
new g_Round = 0
new toggle_switch, toggle_sound, toggle_msg, toggle_msg_sound, friendlyfire, toggle_ff;

public plugin_init()
{
	register_plugin("CFG Nextmap Chooser", "1.4", "AMXX&mut2nt&anakin");

	register_event("HLTV","new_round","a","1=0","2=0");
	register_event("TextMsg", "round_restart", "a", "2&#Game_C", "2&#Game_w");

	g_mapName=ArrayCreate(32);
	
	new MenuName[64];
	
	format(MenuName, 63, "Urmatoarea Harta");
	register_menucmd(register_menuid(MenuName), (-1^(-1<<(SELECTMAPS+2))), "countVote");

	register_cvar("amx_extendmap_max", "90");
	register_cvar("amx_extendmap_step", "15");
	register_cvar("amx_vote_answers", "1");

	toggle_switch = register_cvar("cfg_mc_switch", "1");
	toggle_sound = register_cvar("cfg_mc_sound", "1");
	toggle_msg = register_cvar("cfg_mc_msg", "1");
	toggle_msg_sound = register_cvar("cfg_mc_sc", "1");
	toggle_ff = register_cvar("cfg_mc_ff", "1");

	register_event("TeamScore", "team_score", "a");
	g_msgsaytext = get_user_msgid("SayText");
	friendlyfire = get_cvar_num("mp_friendlyfire");

	get_localinfo("lastMap", g_lastMap, 31);
	set_localinfo("lastMap", "");

	new maps_ini_file[64]
	get_configsdir(maps_ini_file, 63);
	format(maps_ini_file, 63, "%s/maps.ini", maps_ini_file);
	
	if (!file_exists(maps_ini_file))
	{
		get_cvar_string("mapcyclefile", maps_ini_file, 63);
	}
	if (loadSettings(maps_ini_file))
	{
		set_task(15.0, "voteNextmap", 987456, "", 0, "b");
	}
	g_coloredMenus = colored_menus()
}

public new_round()
{
	++g_Round;
}

public round_restart()
{
	g_Round = 0;
	remove_task(45628);
}

public checkVotes()
{
	new b = 0;

	for (new a = 0; a < g_mapVoteNum; ++a)
	{
		if (g_voteCount[b] < g_voteCount[a])
		{
			b = a;
		}
	}
	
	if (g_voteCount[SELECTMAPS] > g_voteCount[b] && g_voteCount[SELECTMAPS] > g_voteCount[SELECTMAPS+1])
	{
		new mapname[32];
		get_mapname(mapname, 31);

		new Float:steptime = get_cvar_float("amx_extendmap_step");
		set_cvar_float("mp_timelimit", get_cvar_float("mp_timelimit") + steptime);

		print(0, "^x01* Vot^x03 incheiat^x01. Plansa curenta este extinsa pentru^x04 %.0f^x01 minute", steptime);

		if( get_pcvar_num( toggle_switch ) != 0 )
		{

			print(0, "^x01*^x03 Echipele^x01 se vor^x04 schimba^x01!!");
			client_print(0, print_center,"[ Echipele sunt inversate ]");
		
			for (new i=1; i<=32; i++)
			{
				if (!is_user_connected(i) || cs_get_user_team(i) == CS_TEAM_UNASSIGNED || cs_get_user_team(i) == CS_TEAM_SPECTATOR)
				{
					return PLUGIN_CONTINUE;
				}
  
				if (cs_get_user_team(i) == CS_TEAM_T)
				{
					cs_set_user_team(i, CS_TEAM_CT);
				}
				else
				{
					cs_set_user_team(i, CS_TEAM_T);
				}
			}

			client_cmd(0, "spk fvox/bell");
		}

		if( get_pcvar_num( toggle_sound ) != 0 )
		{
			client_cmd(0, "spk fvox/bell");
		}

		return PLUGIN_CONTINUE;
	}

	new smap[32];
	if (g_voteCount[b] && g_voteCount[SELECTMAPS + 1] <= g_voteCount[b])
	{
		ArrayGetString(g_mapName, g_nextName[b], smap, charsof(smap));
		set_cvar_string("amx_nextmap", smap);
	}

	get_cvar_string("amx_nextmap", smap, 31);
	print(0, "^x01* Vot^x03 incheiat^x01. Urmatoarea harta este^x04 %s", smap);

	if(get_pcvar_num(toggle_ff) != 0)
	{
		set_cvar_num("mp_friendlyfire", 1);
		set_hudmessage(255, 0, 0, -1.0, 0.20, 1, 6.0, 6.0, 1.0, 1.0, 2);
		show_hudmessage(0, "FriendlyFire e activat!^nAtentie la coechipieri!");

	}

	return PLUGIN_CONTINUE;
}

public countVote(id, key)
{
	if (get_cvar_float("amx_vote_answers"))
	{
		new name[32];
		get_user_name(id, name, 31);
		
		if (key == SELECTMAPS)
		{
			print(0, "^x01*^x03 %s^x01 alege^x04 extindere", name);
		}

		else if (key < SELECTMAPS)
		{
			new map[32];
			ArrayGetString(g_mapName, g_nextName[key], map, charsof(map));
			print(0, "^x01*^x03 %s^x01 alege^x04 %s", name, map);
		}
	}
	++g_voteCount[key];
	
	return PLUGIN_HANDLED;
}

bool:isInMenu(id)
{
	for (new a = 0; a < g_mapVoteNum; ++a)
	{
		if (id == g_nextName[a])
		{
			return true;
		}
	}

	return false;
}

public voteNextmap()
{
	new winlimit = get_cvar_num("mp_winlimit");
	new maxrounds = get_cvar_num("mp_maxrounds");
	
	if (winlimit)
	{
		new c = winlimit - 2;
		
		if ((c > g_teamScore[0]) && (c > g_teamScore[1]))
		{
			g_selected = false;
			return PLUGIN_CONTINUE;
		}
	}

	else if (maxrounds)
	{
		if ((maxrounds - 2) > (g_teamScore[0] + g_teamScore[1]))
		{
			g_selected = false;
			return PLUGIN_CONTINUE;
		}
	} 

	else 
	{
		new timeleft = get_timeleft();
		
		if (timeleft < 1 || timeleft > 129)
		{
			g_selected = false;
			return PLUGIN_CONTINUE;
		}
	}

	if (g_selected)
	{
		return PLUGIN_CONTINUE;
	}

	g_selected = true;

	new menu[512], a, mkeys = (1<<SELECTMAPS + 1);

	new pos = format(menu, 511, g_coloredMenus ? "\yUrmatoarea Harta:\w^n^n" : "Urmatoarea Harta:^n^n");
	new dmax = (g_mapNums > SELECTMAPS) ? SELECTMAPS : g_mapNums;
	
	for (g_mapVoteNum = 0; g_mapVoteNum < dmax; ++g_mapVoteNum)
	{
		a = random_num(0, g_mapNums - 1);
		
		while (isInMenu(a))
		{
			if (++a >= g_mapNums)
			{
				a = 0;
			}
		}

		g_nextName[g_mapVoteNum] = a;
		pos += format(menu[pos], 511, "%d. %a^n", g_mapVoteNum + 1, ArrayGetStringHandle(g_mapName, a));
		mkeys |= (1<<g_mapVoteNum);
		g_voteCount[g_mapVoteNum] = 0;
	}
	
	menu[pos++] = '^n';
	g_voteCount[SELECTMAPS] = 0;
	g_voteCount[SELECTMAPS + 1] = 0;
	
	new mapname[32];
	get_mapname(mapname, 31);

	if ((winlimit + maxrounds) == 0 && (get_cvar_float("mp_timelimit") < get_cvar_float("amx_extendmap_max")))
	{
		pos += format(menu[pos], 511, "%d.\yExtindere harta\r %s^n", SELECTMAPS + 1, mapname);
		mkeys |= (1<<SELECTMAPS);
	}

	format(menu[pos], 511, "%d.\rNici un vot", SELECTMAPS+2);
	new MenuName[64];
	
	format(MenuName, 63, "Urmatoarea Harta");
	show_menu(0, mkeys, menu, 15, MenuName);
	set_task(15.0, "checkVotes");
	print(0, "^x01* Este timpul pentru^x04 vot^x01...");

	if( get_pcvar_num( toggle_msg ) != 0 )
	{
		set_task(1.0, "time_remaining", 45628,_,_, "b")
	}

	client_cmd(0, "stopsound")
	client_cmd(0, "spk Gman/Gman_Choose2");

	return PLUGIN_CONTINUE;
}

public time_remaining(id)
{
	new timeleft = get_timeleft();

	if(--timeleft > 0)
	{
		set_hudmessage(255,255,255, 0.01, 0.20, 0, 6.0, 2.0, 0.1, 0.2, 4);
		show_hudmessage(0,"Time remaining: %d:%02d", timeleft / 60, timeleft % 60);

		if(get_pcvar_num(toggle_msg_sound) != 0)
		{
			if(timeleft < 11)
			{
				new tl[32];
				num_to_word(timeleft, tl, 31);
				client_cmd(0, "spk ^"vox/%s^" ", tl);
			}
		}
	}

	return PLUGIN_CONTINUE;
}

stock bool:ValidMap(mapname[])
{
	if (is_map_valid(mapname))
	{
		return true;
	}

	new len = strlen(mapname) - 4;
	
	if (len < 0)
	{
		return false;
	}

	if ( equali(mapname[len], ".bsp") )
	{
		mapname[len] = '^0';
		
		if ( is_map_valid(mapname) )
		{
			return true;
		}
	}
	
	return false;
}

loadSettings(filename[])
{
	if (!file_exists(filename))
	{
		return PLUGIN_CONTINUE;
	}

	new szText[32], currentMap[32], buff[256];
	get_mapname(currentMap, 31);

	new fp=fopen(filename,"r");
	
	while (!feof(fp))
	{
		buff[0]='^0';
		
		fgets(fp, buff, charsof(buff));
		
		parse(buff, szText, charsof(szText));
		
		
		if (szText[0] != ';' && ValidMap(szText) && !equali(szText, g_lastMap) && !equali(szText, currentMap))
		{
			ArrayPushString(g_mapName, szText);
			++g_mapNums;
		}
	}
	
	fclose(fp);

	return g_mapNums;
}

public team_score()
{
	new team[2];
	
	read_data(1, team, 1);
	g_teamScore[(team[0]=='C') ? 0 : 1] = read_data(2);
}

public plugin_end()
{
	remove_task(45628);
	set_cvar_num("mp_friendlyfire",friendlyfire);

	new current_map[32];
	get_mapname(current_map, 31);
	set_localinfo("lastMap", current_map);
}