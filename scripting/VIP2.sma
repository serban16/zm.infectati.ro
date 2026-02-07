
#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>
#include <fakemeta_util>
#include <hamsandwich>
#include <engine>

#define Keysrod (1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<9)
#define ITEM_HE                (1<<0) // "a" 
#define ITEM_FS                (1<<1) // "b" 
#define ITEM_DG                (1<<3) // "d" 
#define ITEM_VH                (1<<4) // "e"
#define ITEM_DF                (1<<5) // "f"
#define ITEM_NV                (1<<6) // "g"

new jumpnum[33] = 0
new bool:has_parachute[33]
new para_ent[33]
new pDetach, pFallSpeed, pEnabled
new bool:dojump[33] = false
new hk_File4[ 128 ];
new hk_VipsList[ 128 ][ 32 ], hk_TotalLines;
new hk_IsUserVip[ 33 ];
new hk_viplist[ ] = "vips_list.ini";
new hk_Folder[ ] = "Vip";
new hk_cfg[ ] = "vip-config";
new hk_File[ 128 ];
new hk_File1[ 128 ];
new g_type, g_hudmsg
new vip_hud
new maxplayers
new mpd, mkb, mhb
new health_add
new health_hs_add
new health_max
new hk_Killer
new hk_KillerHp
new hk_HpAdd
new hk_HpMax
new jumps, items
new hk_iRoundCount
new bool:hk_IsRestarting
new gun_menu
new cvardmg

enum
{
	Primary = 1
	, Secondary
	, Knife
	, Grenades
	, C4
};

public plugin_init() 
{
	register_plugin("Vip", "2.1", "Hasky")
	
	pEnabled = register_cvar("sv_parachute", "1" )
    pFallSpeed = register_cvar("parachute_fallspeed", "100")
    pDetach = register_cvar("parachute_detach", "1")
    
    register_clcmd("say", "HandleSay")
    register_clcmd("say_team", "HandleSay")

    register_event("ResetHUD", "newSpawn", "be")
    
    //Setup jtp10181 CVAR
    new cvarString[256], shortName[16]
    copy(shortName,15,"chute")
    
    register_cvar("jtp10181","",FCVAR_SERVER|FCVAR_SPONLY)
    get_cvar_string("jtp10181",cvarString,255)
    
    if (strlen(cvarString) == 0) {
        formatex(cvarString,255,shortName)
        set_cvar_string("jtp10181",cvarString)
    }
    else if (contain(cvarString,shortName) == -1) {
        format(cvarString,255,"%s,%s",cvarString, shortName)
        set_cvar_string("jtp10181",cvarString)
    }	
	register_concmd("say /listavip", "showAdmin", ADMIN_ALL, "")
	register_concmd("amx_addvips", "addvips", ADMIN_RCON, "<Nume sau SteamID>")
	register_concmd("amx_vips", "vips", ADMIN_RCON, "Lista Vip-urilor")

	register_clcmd( "say /vip", "ShowAbilityForVip" );
	register_clcmd( "say_team /vip", "ShowAbilityForVip" );
	
	RegisterHam ( Ham_Spawn, "player", "Hook_PlayerSpawn", 1 )
	register_event("Damage", "on_damage", "b", "2!0", "3=0", "4!0")
	register_event("DeathMsg", "hook_death", "a", "1>0")
	register_event("Damage","Damage","b")
	register_event("DeathMsg","death_msg","a")
	register_menucmd(register_menuid("rod"), Keysrod, "Pressedrod")
	register_event("TextMsg", "Event_TextMsg_Restart", "a", "2&#Game_C", "2&#Game_w")
	register_event("HLTV", "Event_HLTV_New_Round", "a", "1=0", "2=0")
	RegisterHam(Ham_TakeDamage, "player", "Ham_CBasePlayer_TakeDamage_Pre") 
	
	register_cvar("vip_maxjumps","1")
	jumps = register_cvar("vip_jumps","1")
	vip_hud = register_cvar("vip_hud","1")
	g_type = register_cvar("vip_bulletdamage","1")
	health_add = register_cvar("vip_hp_kill", "10")
	health_hs_add = register_cvar("vip_hp_hs", "25")
	health_max = register_cvar("vip_hp_max", "100")
	mpd = register_cvar("vip_money_damage","3")
	mkb = register_cvar("vip_money_kill","500")
	mhb = register_cvar("vip_money_hs","1000")
	items = register_cvar("vip_items_round", "abcdefg")
	gun_menu = register_cvar("vip_gun_menu","1")
	cvardmg = register_cvar("vip_damage","2")
	g_hudmsg = CreateHudSyncObj()
	maxplayers = get_maxplayers()
	
	
}

public plugin_cfg()
{	
	
	
	new Dir[ 64 ];
	get_configsdir(Dir,charsmax(Dir));
	formatex ( hk_File, charsmax ( hk_File ), "%s/%s", Dir, hk_Folder );
	formatex ( hk_File1, charsmax ( hk_File1 ), "%s/%s.cfg", hk_File, hk_cfg );
	if(!dir_exists(hk_File))
	mkdir(hk_File);

	formatex ( hk_File4, charsmax ( hk_File4 ), "%s/%s", hk_File, hk_viplist );
	
	if (!file_exists(hk_File4))
	write_file(hk_File4,"; -->VIP List<--");
	
	new hk_Buffer[ 192 ], hk_Line, hk_Len;
	while ( ( hk_Line = read_file ( hk_File4, hk_Line, hk_Buffer, charsmax ( hk_Buffer ), hk_Len ) ) )
	{
		if ( ! strlen ( hk_Buffer ) || hk_Buffer[ 0 ] == ';' || ( hk_Buffer[ 0 ] == '/' && hk_Buffer[ 1 ] == '/' ) )
			continue;
			
		copy ( hk_VipsList[ hk_TotalLines++ ], 32, hk_Buffer );

	}	
	
	if(!file_exists(hk_File1))
	{
	write_file(hk_File1,"// Vip Configuration File")
	write_file(hk_File1,"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// BulletDamage - afiseaza dmg-ul facut unui jucator")
	write_file(hk_File1,"// 1 - Activat   0 - Dezactivat")
	write_file(hk_File1,"vip_bulletdamage ^"1^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Vips Online")
	write_file(hk_File1,"// Arata Vip-urile online in HUD prin scrierea in chat a comenzii /vips")
	write_file(hk_File1,"// 1 - Activat   0 - Dezactivat")
	write_file(hk_File1,"vip_hud ^"1^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Hp primit pe un kill  ")
	write_file(hk_File1,"vip_hp_kill ^"10^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Hp primit pe un hs")
	write_file(hk_File1,"vip_hp_hs ^"25^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Valoarea maxima a hp-ului pe care o poate avea Vip-ul")
	write_file(hk_File1,"vip_hp_max ^"100^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Banii primiti pe un damage")
	write_file(hk_File1,"vip_money_damage ^"3^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Banii primiti pe un kill")
	write_file(hk_File1,"vip_money_kill ^"500^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Banii primiti pe un hs")
	write_file(hk_File1,"vip_money_hs ^"1000^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Guns Menu - afiseaza meniul cu arme")
	write_file(hk_File1,"// Pe hartile de tip AWP, acest meniu va fi automat dezactivat")
	write_file(hk_File1,"// 1 - Activat   0 - Dezactivat")
	write_file(hk_File1,"vip_gun_menu ^"1^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Items per round - primiti diverse obiecte la inceputul fiecarei runde")
	write_file(hk_File1,"// a - He Grenade")
	write_file(hk_File1,"// b - Flashbang (x2)")
	write_file(hk_File1,"// d - Deagle")
	write_file(hk_File1,"// e - Vest + Helm")
	write_file(hk_File1,"// f - Defuse Kit (Doar CT)")
	write_file(hk_File1,"// g - NightVision")
	write_file(hk_File1,"vip_items_round ^"abcdefg^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Jumps - Salturi")
	write_file(hk_File1,"// 1 - Activat   0 - Dezactivat")
	write_file(hk_File1,"vip_jumps ^"1^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// Cate sarituri in plus poate sa faca deodata")
	write_file(hk_File1,"vip_maxjumps ^"1^"")
	write_file(hk_File1,"")
	write_file(hk_File1,"// De cate ori damage-ul jucatorului se mareste indiferent de arma")
	write_file(hk_File1,"// ex: daca este 2, atunci jucatorului i se mareste dmg-ul de 2 ori")
	write_file(hk_File1,"vip_damage ^"2^"")
	write_file(hk_File1,"")
	
	
	}
	
	server_cmd("exec %s",hk_File1)
}
public plugin_natives()
{
    set_module_filter("module_filter")
    set_native_filter("native_filter")
}

public module_filter(const module[])
{
    if (!cstrike_running() && equali(module, "cstrike")) {
        return PLUGIN_HANDLED
    }
    
    return PLUGIN_CONTINUE
}

public native_filter(const name[], index, trap)
{
    if (!trap) return PLUGIN_HANDLED
    
    return PLUGIN_CONTINUE
}
public newSpawn(id)
{
    if(para_ent[id] > 0) {
        remove_entity(para_ent[id])
        set_user_gravity(id, 1.0)
        para_ent[id] = 0
    }
    
    has_parachute[id] = true
}

public HandleSay(id)
{
    if(!is_user_connected(id)) return PLUGIN_CONTINUE
    
    new args[128]
    read_args(args, 127)
    remove_quotes(args)
    
    return PLUGIN_CONTINUE
}
public plugin_precache() 
{
	precache_model("models/parachute.mdl")
}

public client_putinserver(id)
{
	
	hk_IsUserVip[ id ] = 0;
	jumpnum[id] = 0
	dojump[id] = false
}

public resetModel(id, level, cid) {
	if(para_ent[id] > 0)
	{
		remove_entity(para_ent[id])
		set_user_gravity(id, 1.0)
		para_ent[id] = 0
	}
	has_parachute[id] = true
}

public client_disconnect(id)
{
	
	hk_IsUserVip[ id ] = 0;
	jumpnum[id] = 0
	dojump[id] = false
}
public addvips(id, level, cid)
{
	if (!cmd_access(id, level, cid, 2))
		return PLUGIN_HANDLED

	new arg[32]	
	
	read_argv(1, arg, 31)
	
	new szLog[256];
	formatex(szLog,255,"%s",arg);
	write_file(hk_File4,szLog,-1);
	console_print(id, "[CS16] Vip-ul a fost adaugat in lista")
	
	return PLUGIN_HANDLED
	
}
public vips(id, level, cid)
{
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED
	
	new s_Name[ 32 ], s_AuthID[ 32 ];
	get_user_name ( id, s_Name, 31 );
	get_user_authid ( id, s_AuthID, 31 );
	
	console_print(id, "===========================")
	for ( new i; i < hk_TotalLines; i++ )
	{
		if (  strcmp ( s_Name, hk_VipsList[ i ] ) || strcmp ( s_AuthID, hk_VipsList[ i ] ) )
		console_print(id, " - %s", hk_VipsList[ i ])	
			
		
	}
	console_print(id, "===========================")
	return PLUGIN_HANDLED
}


public Event_TextMsg_Restart()
{
    hk_IsRestarting = true
}
 
public Event_HLTV_New_Round()
{
    if( hk_IsRestarting )
    {
        hk_IsRestarting = false
        hk_iRoundCount = 0
    }
}

public Hook_PlayerSpawn ( const id )
{
	if ( ! is_user_alive ( id ) )
		return HAM_IGNORED;
	if ( ! is_user_vip ( id ) )
	{
		hk_IsUserVip[ id ] = 0;
		return HAM_IGNORED;
	}
	
	hk_IsUserVip[ id ] = 1;
	hk_iRoundCount++
	new map[32];
	get_mapname(map,31);
	
	if(equali(map, "awp_", 3))
	return HAM_IGNORED;
	
	if (get_pcvar_num(gun_menu) == 1)
	if(hk_iRoundCount>=1)
	Showrod(id);
	
	set_task(0.3, "giveitems", id)
	return HAM_IGNORED;
}

public Ham_CBasePlayer_TakeDamage_Pre( const id, const iInflictor, const iAttacker, const Float:flDamage, const iDamageType ) 
{
	if ( ! is_user_vip ( iAttacker ) || !is_user_connected(iAttacker) )
	{
		hk_IsUserVip[ iAttacker ] = 0;
		return HAM_IGNORED;
	}
	hk_IsUserVip[ iAttacker ] = 1;
	
	new dmg1 = get_pcvar_num(cvardmg)
	
	if( iDamageType == DMG_FALL ) 
	SetHamParamFloat(4, flDamage*1)
	else
	SetHamParamFloat(4, flDamage*dmg1)
	
	return HAM_IGNORED
}

public on_damage(id)
{
	if(get_pcvar_num(g_type))
	{
		static attacker; attacker = get_user_attacker(id)
		static damage; damage = read_data(2)	

		if ( is_user_vip ( attacker ) )
		{
			hk_IsUserVip[ id ] = 1;
		
			if(is_user_connected(attacker))
			{
				if(fm_is_ent_visible(attacker,id))
				{
					set_hudmessage(0, 100, 200, -1.0, 0.55, 2, 0.1, 4.0, 0.02, 0.02, -1)
					ShowSyncHudMsg(attacker, g_hudmsg, "%i^n", damage)				
				}
					
				
			}
		}else hk_IsUserVip[ id ] = 0;
	}
}

public Damage(id)
{
	new weapon, hitpoint, attacker = get_user_attacker(id,weapon,hitpoint)
	if(attacker<=maxplayers && is_user_alive(attacker) && attacker!=id)
	
	if ( is_user_vip ( id ) )
	{
		hk_IsUserVip[ id ] = 1;
		new money = read_data(2) * get_pcvar_num(mpd)
		if(hitpoint==1) money += get_pcvar_num(mhb)
		cs_set_user_money(attacker,cs_get_user_money(attacker) + money)
	}else hk_IsUserVip[ id ] = 0;
}

public death_msg()
{
	if(read_data(1)<=maxplayers && read_data(1) && read_data(1)!=read_data(2)) 
	cs_set_user_money(read_data(1),cs_get_user_money(read_data(1)) + get_pcvar_num(mkb) - 300)
}

public hook_death()
{
	hk_Killer = read_data(1)
   
	if ( (read_data(3) == 1) && (read_data(5) == 0) )
	{
		hk_HpAdd = get_pcvar_num (health_hs_add)
	}
	else
	hk_HpAdd = get_pcvar_num (health_add)
	
	hk_HpMax = get_pcvar_num (health_max)
   
   
	if ( ! is_user_vip ( hk_Killer ) )
	{
		hk_IsUserVip[ hk_Killer ] = 0;
		return;
	}
	hk_IsUserVip[ hk_Killer ] = 1;
	
	hk_KillerHp = get_user_health(hk_Killer)
	hk_KillerHp += hk_HpAdd
   
	if (hk_KillerHp > hk_HpMax) hk_KillerHp = hk_HpMax
	set_user_health(hk_Killer, hk_KillerHp)

	set_hudmessage(0, 255, 0, -1.0, 0.15, 0, 1.0, 1.0, 0.1, 0.1, -1)
	show_hudmessage(hk_Killer, "Healed +%d hp", hk_HpAdd)

}

public showAdmin(id)
{
	if(get_pcvar_num(vip_hud) == 1)
	{
			
		
		new num, iLen, admin
		static pl[32], name[32], szBuff[2048]
	
		get_players(pl, num, "c")
	
		for(new i = 0; i < num; i++)
		{
			if (  is_user_vip ( pl[i] ) )
			{
			hk_IsUserVip[ pl[i] ] = 1;
			get_user_name(pl[i], name, 31)
			iLen += format(szBuff[iLen], 2048 - iLen, "%d. %s^n", admin + 1, name)
			admin++
			}
			
		}

	
		set_hudmessage(0, 255, 0, 0.02, 0.2, 0, 6.0, 7.0 )
		show_hudmessage(id, " %s online:^n%s", admin > 1 ? "Vips" : "Vips", szBuff)
	
		arrayset(szBuff, 0, 2048)
	}
	return PLUGIN_HANDLED
}

public client_PreThink(id)
{
		if(!is_user_alive(id)) return PLUGIN_CONTINUE
		if(get_pcvar_num(jumps) == 0) return PLUGIN_CONTINUE
	
		if ( ! is_user_vip ( id ) )
		{
			hk_IsUserVip[ id ] = 0;
			return PLUGIN_CONTINUE
		}
	
	
		hk_IsUserVip[ id ] = 1;
		new nbut = get_user_button(id)
		new obut = get_user_oldbutton(id)
		if((nbut & IN_JUMP) && !(get_entity_flags(id) & FL_ONGROUND) && !(obut & IN_JUMP))
		{
			if(jumpnum[id] < get_cvar_num("vip_maxjumps"))
			{
				dojump[id] = true
				jumpnum[id]++
				return PLUGIN_CONTINUE
			}
		}
		if((nbut & IN_JUMP) && (get_entity_flags(id) & FL_ONGROUND))
		{
			jumpnum[id] = 0
			return PLUGIN_CONTINUE
		}
    if (!is_user_alive(id) || !has_parachute[id])
        return PLUGIN_CONTINUE
    
    new Float:fallspeed = get_pcvar_float(pFallSpeed) * -1.0
    new Float:frame
    
    new button = get_user_button(id)
    new oldbutton = get_user_oldbutton(id)
    new flags = get_entity_flags(id)
    
    if (para_ent[id] > 0 && (flags & FL_ONGROUND)) {
        
        if (get_pcvar_num(pDetach)) {
            if (get_user_gravity(id) == 0.1)
                set_user_gravity(id, 1.0)
            
            if (entity_get_int(para_ent[id],EV_INT_sequence) != 2) {
                entity_set_int(para_ent[id], EV_INT_sequence, 2)
                entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                entity_set_float(para_ent[id], EV_FL_animtime, 0.0)
                entity_set_float(para_ent[id], EV_FL_framerate, 0.0)
            }
            
            frame = entity_get_float(para_ent[id],EV_FL_fuser1) + 2.0
            entity_set_float(para_ent[id],EV_FL_fuser1,frame)
            entity_set_float(para_ent[id],EV_FL_frame,frame)
            
            if (frame > 254.0) {
                remove_entity(para_ent[id])
                para_ent[id] = 0
            }
        }
        else {
            remove_entity(para_ent[id])
            set_user_gravity(id, 1.0)
            para_ent[id] = 0
        }
    }
    
    if (button & IN_USE) {
        
        new Float:velocity[3]
        entity_get_vector(id, EV_VEC_velocity, velocity)
        
        if (velocity[2] < 0.0) {
            
            if(para_ent[id] <= 0) {
                para_ent[id] = create_entity("info_target")
                if(para_ent[id] > 0) {
                    entity_set_string(para_ent[id],EV_SZ_classname,"parachute")
                    entity_set_edict(para_ent[id], EV_ENT_aiment, id)
                    entity_set_edict(para_ent[id], EV_ENT_owner, id)
                    entity_set_int(para_ent[id], EV_INT_movetype, MOVETYPE_FOLLOW)
                    entity_set_model(para_ent[id], "models/parachute.mdl")
                    entity_set_int(para_ent[id], EV_INT_sequence, 0)
                    entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                    entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                    entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                }
            }
            
            if (para_ent[id] > 0) {
                
                entity_set_int(id, EV_INT_sequence, 3)
                entity_set_int(id, EV_INT_gaitsequence, 1)
                entity_set_float(id, EV_FL_frame, 1.0)
                entity_set_float(id, EV_FL_framerate, 1.0)
                set_user_gravity(id, 0.1)
                
                velocity[2] = (velocity[2] + 40.0 < fallspeed) ? velocity[2] + 40.0 : fallspeed
                entity_set_vector(id, EV_VEC_velocity, velocity)
                
                if (entity_get_int(para_ent[id],EV_INT_sequence) == 0) {
                    
                    frame = entity_get_float(para_ent[id],EV_FL_fuser1) + 1.0
                    entity_set_float(para_ent[id],EV_FL_fuser1,frame)
                    entity_set_float(para_ent[id],EV_FL_frame,frame)
                    
                    if (frame > 100.0) {
                        entity_set_float(para_ent[id], EV_FL_animtime, 0.0)
                        entity_set_float(para_ent[id], EV_FL_framerate, 0.4)
                        entity_set_int(para_ent[id], EV_INT_sequence, 1)
                        entity_set_int(para_ent[id], EV_INT_gaitsequence, 1)
                        entity_set_float(para_ent[id], EV_FL_frame, 0.0)
                        entity_set_float(para_ent[id], EV_FL_fuser1, 0.0)
                    }
                }
            }
        }
        else if (para_ent[id] > 0) {
            remove_entity(para_ent[id])
            set_user_gravity(id, 1.0)
            para_ent[id] = 0
        }
    }
    else if ((oldbutton & IN_USE) && para_ent[id] > 0 ) {
        remove_entity(para_ent[id])
        set_user_gravity(id, 1.0)
        para_ent[id] = 0
    }	
		return PLUGIN_CONTINUE
}

public client_PostThink(id)
{
	if(!is_user_alive(id)) return PLUGIN_CONTINUE
	if(get_pcvar_num(jumps) == 0) return PLUGIN_CONTINUE
	
	if ( ! is_user_vip ( id ) )
	{
		hk_IsUserVip[ id ] = 0;
		return PLUGIN_CONTINUE
	}
	
	
	hk_IsUserVip[ id ] = 1;
	if(dojump[id] == true)
	{
		new Float:velocity[3]	
		entity_get_vector(id,EV_VEC_velocity,velocity)
		velocity[2] = random_float(265.0,285.0)
		entity_set_vector(id,EV_VEC_velocity,velocity)
		dojump[id] = false
		return PLUGIN_CONTINUE
	}
	
	return PLUGIN_CONTINUE
}

public Showrod(id) 
{
	show_menu(id, Keysrod, "Guns Menu^n\w1. M4+Deagle^n\w2. AK47+Deagle^n\w3. AWP + Deagle^n\w0. Exit^n", -1, "rod")
}

public Pressedrod(id, key) 
{
	
	switch (key) {
		case 0: { 
			StripWeapons(id, Primary)
			give_item(id,"weapon_m4a1")
			cs_set_user_bpammo(id, CSW_M4A1, 90 );
			}

		case 1: { 
			StripWeapons(id, Primary)
			give_item(id,"weapon_ak47")
			cs_set_user_bpammo(id, CSW_AK47, 90);
			}

		case 2: { 
			StripWeapons(id, Primary)
			give_item(id,"weapon_awp")
			cs_set_user_bpammo(id, CSW_AWP, 30);
			}
		}

}

public get_item_flags() 
{ 
	new sFlags[24] 
	get_pcvar_string(items,sFlags,23) 
	return read_flags(sFlags) 
} 


public ShowAbilityForVip( id ) {

	new iCfgDir[ 32 ], iFile[ 192 ];
        
	get_configsdir( iCfgDir, charsmax( iCfgDir ) );
	formatex( iFile, charsmax( iFile ), "%s/vip.html", iCfgDir );

	show_motd( id, iFile );
}


public giveitems(id)
{
		new iFlags = get_item_flags()  
		new CsTeams:userTeam = cs_get_user_team(id)
	
		if (iFlags&ITEM_HE)
		fm_give_item(id,"weapon_hegrenade") 
		
             
		if(iFlags&ITEM_FS)
		{
		fm_give_item(id,"weapon_flashbang") 
		fm_give_item(id,"weapon_flashbang") 
		}
		
		
		
		if(iFlags&ITEM_DG)
		{
		StripWeapons(id, Secondary);
		fm_give_item(id,"weapon_deagle") 
		cs_set_user_bpammo(id, CSW_DEAGLE, 35 );
		}
		
		if(iFlags&ITEM_VH)
		fm_give_item(id,"item_assaultsuit")
	
		if(userTeam == CS_TEAM_CT && iFlags&ITEM_DF)
		fm_give_item(id,"item_thighpack")
		
		if(iFlags&ITEM_NV)
		cs_set_user_nvg(id, 1)
		
		
}

stock is_user_vip ( id )
{
	new s_Name[ 32 ], s_AuthID[ 32 ];
	get_user_name ( id, s_Name, 31 );
	get_user_authid ( id, s_AuthID, 31 );
	
	for ( new i; i < hk_TotalLines; i++ )
	{
		if ( ! strcmp ( s_Name, hk_VipsList[ i ] ) )
			return 1;
		if ( ! strcmp ( s_AuthID, hk_VipsList[ i ] ) )
			return 1;
	}
	
	return 0;

}

stock StripWeapons(id, Type, bool: bSwitchIfActive = true)
{
	new iReturn;
	
	if(is_user_alive(id))
	{
		new iEntity, iWeapon;
		while((iWeapon = GetWeaponFromSlot(id, Type, iEntity)) > 0)
			iReturn = ham_strip_user_weapon(id, iWeapon, Type, bSwitchIfActive);
	}
	
	return iReturn;
}

stock GetWeaponFromSlot( id , iSlot , &iEntity )
{
	if ( !( 1 <= iSlot <= 5 ) )
		return 0;
	
	iEntity = 0;
	const m_rgpPlayerItems_Slot0 = 367;
	const m_iId = 43;
	const XO_WEAPONS = 4;
	const XO_PLAYER = 5;
		
	iEntity = get_pdata_cbase( id , m_rgpPlayerItems_Slot0 + iSlot , XO_PLAYER );
	
	return ( iEntity > 0 ) ? get_pdata_int( iEntity , m_iId , XO_WEAPONS ) : 0;
}  

stock ham_strip_user_weapon(id, iCswId, iSlot = 0, bool:bSwitchIfActive = true)
{
	new iWeapon
	if( !iSlot )
	{
		static const iWeaponsSlots[] = {
			-1,
			2, //CSW_P228
			-1,
			1, //CSW_SCOUT
			4, //CSW_HEGRENADE
			1, //CSW_XM1014
			5, //CSW_C4
			1, //CSW_MAC10
			1, //CSW_AUG
			4, //CSW_SMOKEGRENADE
			2, //CSW_ELITE
			2, //CSW_FIVESEVEN
			1, //CSW_UMP45
			1, //CSW_SG550
			1, //CSW_GALIL
			1, //CSW_FAMAS
			2, //CSW_USP
			2, //CSW_GLOCK18
			1, //CSW_AWP
			1, //CSW_MP5NAVY
			1, //CSW_M249
			1, //CSW_M3
			1, //CSW_M4A1
			1, //CSW_TMP
			1, //CSW_G3SG1
			4, //CSW_FLASHBANG
			2, //CSW_DEAGLE
			1, //CSW_SG552
			1, //CSW_AK47
			3, //CSW_KNIFE
			1 //CSW_P90
		}
		iSlot = iWeaponsSlots[iCswId]
	}

	const XTRA_OFS_PLAYER = 5
	const m_rgpPlayerItems_Slot0 = 367

	iWeapon = get_pdata_cbase(id, m_rgpPlayerItems_Slot0 + iSlot, XTRA_OFS_PLAYER)

	const XTRA_OFS_WEAPON = 4
	const m_pNext = 42
	const m_iId = 43

	while( iWeapon > 0 )
	{
		if( get_pdata_int(iWeapon, m_iId, XTRA_OFS_WEAPON) == iCswId )
		{
			break
		}
		iWeapon = get_pdata_cbase(iWeapon, m_pNext, XTRA_OFS_WEAPON)
	}

	if( iWeapon > 0 )
	{
		const m_pActiveItem = 373
		if( bSwitchIfActive && get_pdata_cbase(id, m_pActiveItem, XTRA_OFS_PLAYER) == iWeapon )
		{
			ExecuteHamB(Ham_Weapon_RetireWeapon, iWeapon)
		}

		if( ExecuteHamB(Ham_RemovePlayerItem, id, iWeapon) )
		{
			user_has_weapon(id, iCswId, 0)
			ExecuteHamB(Ham_Item_Kill, iWeapon)
			return 1
		}
	}

	return 0
} 