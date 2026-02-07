/*================================================================================
	-------------------------------------------
	-*- [ZP] Extra Item: Blood Stone | by Re.Act!ve -*-
	-------------------------------------------

	~~~~~~~~~~~~~~~
	- Description -
	~~~~~~~~~~~~~~~	
	[RU] Эта вещь наделяет вас способностью "БлудСтоун". Когда вы вешаете эту штуку на человека, каждый его 
	последующий шаг будет приносить ему боль, отнимая жизни до тех пор пока он не умрет или ни кончится действие 	способности. Чтобы не терять жизней он должен остановится.
	[EN] This thing allocates you with ability of "Blood Stone". When you hang up this piece on the person, its each subsequent 
	step will bring to it a pain, taking away lives until then while he won't die or ability action will come to an end. Not to lose lives 
	it should will stop.

	~~~~~~~~~~~~~~~
	- Credits -
	~~~~~~~~~~~~~~~
	Re.Act!ve 			This Creator of zombie class plugin
	JTP10181			Thanks to Amx Gore Ultimate code

	~~~~~~~~~~~~~~~
	- Changelog -
	~~~~~~~~~~~~~~~
	v. 1.0 - First Plugin Released
	v. 1.1 - Fixed Bug CoolDown & Added New option
	v. 1.2 - Added Effect AMX Gore Blood Stream
	v. 1.3 - Fixed RunTime Error. fixed health death bug.
	v. 1.4 - Fixed Bug No Win Ammo packs. Add Sound miss bloodstone. Fixed small bugs
================================================================================*/

#include <amxmodx>
#include <engine>
#include <fakemeta_util>
#include <zombieplague>

#define PLUGIN "[ZP] Extra Item: Blood Stone"
#define VERSION "1.4"
#define AUTHOR "Re.Act!ve"
#define is_valid_player(%1) (1 <= %1 <= 32)

// Amx Gore Defined
#define MAX_PLAYERS 32
#define GORE_BLEEDING       (1<<2)
#define BLOOD_STREAM_RED	70

new const g_item_name[] = { "Blood Stone" }; // Item name
new const g_item_cost = 10 ; // Item cost
new const sound_buy[] = 		{ "items/gunpickup2.wav" } // Sound Buy
new const sound_miss[] = 		{ "zombie_plague/bloodstone_miss.wav" }
new const sound_blood_start[] = { "zombie_plague/bloodstone_start.wav" }
new const sound_blood_end[] = 	{ "zombie_plague/bloodstone_end.wav" }
new SayText
new g_item_blood, gMsgScreenFade, g_blood_type, g_blood_num, g_blood_dist, g_blood_time, g_blood_remove, g_blood_health, g_blood_cdown, g_blood_infect, g_True
new g_blood_wintype, g_blood_give, g_BloodNum[32], g_Times[33]
new Float:g_Bloodtime[32]
new bool:g_item[33], g_Number[33], g_CoolDown[33], g_Blood[33], g_ability[33], g_ShowHud[33], g_Death[33]

public plugin_init() 
{
	g_blood_type = 		register_cvar("zp_bloodstone_bind_type", "1")	// 0 - Binded bloodstone, 1 - bind B.
	g_blood_num = 		register_cvar("zp_bloodstone_number", "10")	// Number use ability, 0 - Unlimited
	g_blood_dist = 		register_cvar("zp_bloodstone_dist", "620.0")		// Distance ability
	g_blood_time = 		register_cvar("zp_bloodstone_time", "12.0")		// Time is activite ability
	g_blood_remove = 	register_cvar("zp_bloodstone_remove", "0.1")	// Every second in cvar zp_bloodstone_health
	g_blood_health = 	register_cvar("zp_bloodstone_health", "2")		// Health in cvar zp_bloodstone_remove, if human is going
	g_blood_cdown = 	register_cvar("zp_bloodstone_cdown", "5.0")		// cooldown ability
	g_blood_infect = 	register_cvar("zp_bloodstone_infection", "0")		// If in human health < 1; 0 - Death human, 1 - Infection human.
	g_blood_wintype = 	register_cvar("zp_bloodstone_wintype", "1")		// 1 - Give Health, if human death, 0 - ammo packs
	g_blood_give = 		register_cvar("zp_bloodstone_gives", "5")		// Give X health/ammopacks

	g_item_blood = zp_register_extra_item(g_item_name, g_item_cost, ZP_TEAM_ZOMBIE)
	register_clcmd("bloodstone", "cmd_Blood")
       	register_event("StatusValue","show_status","be","1=2","2!0")
      	register_event("StatusValue","hide_status","be","1=1","2=0")
	set_task(1.0,"event_blood",100,"",0,"b")
	gMsgScreenFade = get_user_msgid("ScreenFade")
	register_event("DeathMsg", "DeathZombie", "a")
	register_event("HLTV", "round_start", "a", "1=0", "2=0")	
	register_plugin(PLUGIN, VERSION, AUTHOR)
	SayText = get_user_msgid("SayText")
	register_dictionary("zp_extra_bloodstone.txt")
}

public plugin_precache()
{
        precache_sound( sound_buy )
        precache_sound( sound_miss )
	precache_sound( sound_blood_start )
	precache_sound( sound_blood_end )
}

public DeathZombie()
{
	new id = read_data(2)
	g_item[id] = false;
	g_ability[id] = false;
	g_Number[id] = false;
}

public client_putinserver(id)
g_Number[id] = false;

public zp_extra_item_selected(id, item)
{
	if ( item == g_item_blood )
	{
		if( !g_Number[id] && !zp_is_survivor_round() && zp_get_user_zombie(id) && !zp_is_nemesis_round() )
		{
			g_item[id] = true;
			emit_sound(id, CHAN_STREAM, sound_buy, 1.0, ATTN_NORM, 0, PITCH_HIGH )
			g_BloodNum[id] = get_pcvar_num(g_blood_num);
			g_CoolDown[id] = true;
			if( get_pcvar_num(g_blood_type) == 1)
			{
				ChatColor(id, "!g[ZP]!y %L", LANG_PLAYER, "BLOOD_BUY", g_BloodNum[id])
				client_cmd(id, "bind b bloodstone")
			}
			else
			ChatColor(id, "!g[ZP]!y %L", LANG_PLAYER, "BLOOD_NOBIND", g_BloodNum[id])
			g_Number[id] = true;
			set_task(1.0, "ShowHud", id, _, _, "b")
		}
		else
		{
			g_Number[id] = true;
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + g_item_cost)
			ChatColor(id, "!g[ZP]!y %L", LANG_PLAYER, "BLOOD_BOUTH")	
		}	
	}
}

public ShowHud(id)
{
	if( g_item[id] && zp_get_user_zombie(id) && is_user_alive(id) && (g_BloodNum[id] > 0) )
	{
		set_hudmessage(200, 70, 0, 0.45, 0.8, 0, 1.0, 1.0, 0.0, 0.0, -1)
		show_hudmessage(id, "%L", LANG_PLAYER, "BLOODSTONES", g_BloodNum[id]); 
	}
	else
	remove_task(id)
}

public zp_user_infected_post(id, infector)
{
	g_item[id] = false;
	g_ability[id] = false;
	g_Number[id] = false;
}

public cmd_Blood(id)
{
	if( g_item[id] && zp_get_user_zombie(id) && !zp_is_survivor_round() && g_CoolDown[id] && is_user_alive(id))
	{
		if(g_BloodNum[id] > 0)
		{
			g_BloodNum[id] = g_BloodNum[id] - 1;
			ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "NUMBER_BLOOD", g_BloodNum[id])
			set_task(0.1, "BloodStone_Active", id)
		}
		else
		{
			g_Number[id] = false;
			ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "DONT_BLOOD")
		}
	}
}

public BloodStone_Active(id)
{
	new target, body,dist; dist = get_pcvar_num(g_blood_dist)
	get_user_aiming(id, target, body, dist)
	g_True = 0;
	if(!target)
	{
		g_CoolDown[id] = false;	
		set_task(get_pcvar_float(g_blood_cdown), "Reset_CoolDown", id)
		emit_sound(target, CHAN_STREAM, sound_miss, 1.0, ATTN_NORM, 0, PITCH_HIGH )
	}
	else
	{
		if( is_valid_ent( target ) && !zp_get_user_zombie(target) && is_user_alive(target) && (get_entity_distance( id, target ) <= dist) && g_CoolDown[id])
		{
			emit_sound(target, CHAN_STREAM, sound_blood_start, 1.0, ATTN_NORM, 0, PITCH_HIGH )
			g_Blood[target] = true; g_CoolDown[id] = false; g_ability[id] = true; g_ShowHud[id] = true;
			g_Bloodtime[target] = get_pcvar_float(g_blood_time);
			g_Times[id] = get_pcvar_num(g_blood_time);
			set_task(get_pcvar_float(g_blood_time), "Win_False", id);
			set_task(get_pcvar_float(g_blood_cdown) + g_Bloodtime[target], "Reset_CoolDown", id)
			set_task(get_pcvar_float(g_blood_remove), "Human_Bloodes", target)
			set_task(1.0, "Human_Distance", id, _, _, "a", g_Times[id])
		}
	}
}

public Human_Distance(id)
{
	new Float:origin_id[3], Float:origin_2[3]
	pev(id, pev_origin, origin_id)
	g_Times[id] = g_Times[id] - 1;
	if(g_True != 0)
	{
		g_True = 0;
		if(get_pcvar_num(g_blood_infect) != 1)
		ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "DEAD_PLAYER")	
		else
		ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "INFECT_PLAYER")

		Human_death(id)
		remove_task(id)
	}
	for(new i=1;i<=32;i++)
	{
		pev(i,pev_origin,origin_2)
		if( (vector_distance(origin_id,origin_2) != 0) && g_Death[i] )	
		{
			g_True = 1;
			g_Death[i] = false;
		}	
	}
}

Human_death(id)
{
	if( zp_get_user_zombie(id) && g_item[id])
	{
		g_ability[id] = false;
		if(get_pcvar_num(g_blood_wintype) == 0)
		{
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + get_pcvar_num(g_blood_give))
			ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "WIN_AMMO")
		}
		else
		{
			fm_set_user_health(id, get_user_health(id) + get_pcvar_num(g_blood_give))
			ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "WIN_HEALTH")
			message_begin(MSG_ONE_UNRELIABLE, gMsgScreenFade, {0, 0, 0}, id)
			write_short(1<<10)
			write_short(1<<10)
			write_short(0x0000)
			write_byte(200)
			write_byte(40)
			write_byte(0)
			write_byte(20)
			message_end()
		}
	}
}

public hide_status(id)
{
    	set_hudmessage(0,0,0,0.0,0.0,0, 0.0, 0.01, 0.0, 0.0, 4)
    	show_hudmessage(id,"")
}

public show_status(id)
{
	new target = read_data(2)
 	if( zp_get_user_zombie(id) && !zp_get_user_zombie(target) && g_Blood[target] && g_item[id] )
	{
		set_hudmessage(200, 0, 0, 0.45, 0.8, 0, 1.0, 0.2, 0.0, 0.0, -1)
		show_hudmessage(target, "Heath Victim: %d", get_user_health(target)); 
	}
}

public Win_False(id)
{
	g_ShowHud[id] = false;
	g_ability[id] = false;
}

public Human_Bloodes(target)
{
	if( (g_Bloodtime[target] > 0.1) && g_Blood[target] && !zp_get_user_zombie(target) )
	{
		set_hudmessage(200, 0, 0, 0.45, 0.8, 0, 1.0, 0.2, 0.0, 0.0, -1)
		show_hudmessage(target, "%L", LANG_PLAYER, "HUD_VICTIM"); 
		fm_set_rendering( target, kRenderFxGlowShell, 200, 0, 0, kRenderNormal, 16 ) 
		g_Bloodtime[target] = g_Bloodtime[target] - get_pcvar_float(g_blood_remove);
		if(fm_get_speed(target) > 0)
		{
			if( get_user_health(target) > get_pcvar_num(g_blood_health) )
			{
				g_Death[target] = false;
				fm_set_user_health(target, get_user_health(target) - get_pcvar_num(g_blood_health))
				message_begin(MSG_ONE_UNRELIABLE, gMsgScreenFade, {0, 0, 0}, target)
				write_short(1<<10)
				write_short(1<<10)
				write_short(0x0000)
				write_byte(200)
				write_byte(0)
				write_byte(0)
				write_byte(20)
				message_end()
			}
			else
			{
				g_Death[target] = true;
				if(get_pcvar_num(g_blood_infect) != 1)
				user_kill(target)
				else
				zp_infect_user(target)
				remove_task(target)
			}
		}
		set_task(get_pcvar_float(g_blood_remove), "Human_Bloodes", target)
	}
	else
	{
		fm_set_rendering( target, 0, 0, 0, 0, kRenderNormal, 25 ) 
		emit_sound(target, CHAN_STREAM, sound_blood_end, 1.0, ATTN_NORM, 0, PITCH_HIGH )
		g_Blood[target] = false;
		remove_task(target)	
	}
}

public Reset_CoolDown(id)
{
	g_CoolDown[id] = true;
	ChatColor(id, "!g[ZP] !y%L", LANG_PLAYER, "COOLDOWN")
}

public event_blood()
{
	new id, iPlayers[MAX_PLAYERS], iNumPlayers, iOrigin[3]
	get_players(iPlayers,iNumPlayers,"a")
	for (new i = 0; i < iNumPlayers; i++) 
	{
		id = iPlayers[i]
		if ( g_Blood[id] ) 
		{
			get_origin_int(id, iOrigin)
			fx_bleed(iOrigin)
		}
	}
}

fx_bleed(origin[3])
{
	// Blood spray
	message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
	write_byte(TE_BLOODSTREAM)
	write_coord(origin[0])
	write_coord(origin[1])
	write_coord(origin[2]+10)
	write_coord(random_num(-360,360)) // x
	write_coord(random_num(-360,360)) // y
	write_coord(-10) // z
	write_byte(BLOOD_STREAM_RED) // color
	write_byte(random_num(50,100)) // speed
	message_end()
}

public get_origin_int(index, origin[3])
{
	new Float:FVec[3]

	pev(index,pev_origin,FVec)

	origin[0] = floatround(FVec[0])
	origin[1] = floatround(FVec[1])
	origin[2] = floatround(FVec[2])

	return 1
}

stock ChatColor(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4") // Green Color
	replace_all(msg, 190, "!y", "^1") // Default Color
	replace_all(msg, 190, "!t", "^3") // Team Color
	
	if (id) players[0] = id; else get_players(players, count, "ch")
	{
		for (new i = 0; i < count; i++)
		{
			if (is_user_connected(players[i]))
			{
				message_begin(MSG_ONE_UNRELIABLE, SayText, _, players[i])
				write_byte(players[i]);
				write_string(msg);
				message_end();
			}
		}
	}
}

public zp_round_ended(winteam)
{
	for (new id; id <= 32; id++) 
	g_Blood[id] = false;
}

public round_start(id)
{
	for (new id; id <= 32; id++) 
	{
		g_item[id] = false;
		g_ability[id] = false;
		g_Number[id] = false;
	}
}