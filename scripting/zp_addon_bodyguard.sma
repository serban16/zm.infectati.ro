#include <amxmodx>
#include <cstrike>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <zombieplague>

g_bground

#define TASK_AURA	85927

#define ID_AURA		(taskid - TASK_AURA)

#define zp_get_grenade_type(%1)		(pev(%1, pev_flTimeStepSound))

// Plugin version
new const VERSION[] = "3.0"

new const MAXBPAMMO[] = { -1, 52, -1, 90, 1, 32, 1, 100, 90, 1, 120, 100, 100, 90, 90, 90, 100, 120,
			30, 120, 200, 32, 90, 120, 90, 2, 35, 90, 90, -1, 100 }

new const MAXCLIP[] = { -1, 13, -1, 10, -1, 7, -1, 30, 30, -1, 30, 20, 25, 30, 35, 25, 12, 20,
			10, 30, 100, 8, 30, 30, 20, -1, 7, 30, 30, -1, 50 }

// NADE_TYPE_INFECTION
const NADE_TYPE_INFECTION = 1111

const PDATA_SAFE = 2
const OFFSET_PAINSHOCK = 108
const OFFSET_ACTIVE_ITEM = 373
const OFFSET_LINUX = 5

new const VIP_MODEL[] = "vip"

// PCvars
new pCvarToggle, pCvarMode, pCvarRewardZ, pCvarRewardH, pCvarRewardV, pCvarHealth, pCvarExtraHealth, pCvarArmor, pCvarGravity, pCvarGlow, pCvarUClip, pCvarPickup, pCvarRespawnZombie, pCvarRespawnDelay,
pCvarAura, pCvarAuraRadius, pCvarPSF, pCvarModelIndex

// Cached PCvars
new cToggle, cMode, cRewardZ, cRewardH, cRewardV, cHealth, cExtraHealth, cArmor, Float:cGravity, cUClip, cPickup, cRespawnZombie, Float:cRespawnDelay, cAuraRadius, cPSF, cModelIndex

// Player variables
new gCurWeapon[33]

// Global variables
new gSwarmPlague

// Message IDs
new gMsgDeathMsg, gMsgScoreInfo

// Hooks
new MaxPlayers

// Forwards
new gFwVIPround, gFwDummyResult

new g_bitConnectedPlayers, g_bitAlivePlayers, g_bitZombiePlayers, g_bitVIPPlayers

#define MarkUserConnected(%0)   g_bitConnectedPlayers |= (1 << (%0 & 31))
#define ClearUserConnected(%0)  g_bitConnectedPlayers &= ~(1 << (%0 & 31))
#define IsUserConnected(%0)	g_bitConnectedPlayers & (1 << (%0 & 31))

#define MarkUserAlive(%0)   	g_bitAlivePlayers |= (1 << (%0 & 31))
#define ClearUserAlive(%0)  	g_bitAlivePlayers &= ~(1 << (%0 & 31))
#define IsUserAlive(%0)		g_bitAlivePlayers & (1 << (%0 & 31))

#define MarkUserZombie(%0)   	g_bitZombiePlayers |= (1 << (%0 & 31))
#define ClearUserZombie(%0)  	g_bitZombiePlayers &= ~(1 << (%0 & 31))
#define IsUserZombie(%0)	g_bitZombiePlayers & (1 << (%0 & 31))

#define MarkUserVIP(%0)   	g_bitVIPPlayers |= (1 << (%0 & 31))
#define ClearUserVIP(%0)  	g_bitVIPPlayers &= ~(1 << (%0 & 31))
#define IsUserVIP(%0)		g_bitVIPPlayers & (1 << (%0 & 31))

public plugin_init()
{
	register_plugin("[ZP] Addon: BodyGuard Mode", VERSION, "eXcalibur.007")
	
	pCvarToggle = register_cvar("zp_enable_bodyguard", "1")
	pCvarMode = register_cvar("zp_bodyguard_swarm", "1")
	pCvarRewardZ = register_cvar("zp_bodyguard_zombie_rewards", "10")
	pCvarRewardH = register_cvar("zp_bodyguard_human_rewards", "10")
	pCvarRewardV = register_cvar("zp_vip_extra_ap", "30")
	pCvarHealth = register_cvar("zp_vip_health", "300")
	pCvarExtraHealth = register_cvar("zp_vip_extra_health", "100")
	pCvarArmor = register_cvar("zp_vip_armor", "0")
	pCvarGravity = register_cvar("zp_vip_gravity", "0.75")
	pCvarGlow = register_cvar("zp_vip_glow", "255 255 255")
	pCvarUClip = register_cvar("zp_vip_unlimited_ammo", "0")
	pCvarPickup = register_cvar("zp_vip_allow_pick_up", "0")
	pCvarRespawnZombie = register_cvar("zp_zombie_inf_respawn", "0")
	pCvarRespawnDelay = register_cvar("zp_zombie_respawn_delay", "5.0")
	pCvarAura = register_cvar("zp_vip_aura", "255 255 255")
	pCvarAuraRadius = register_cvar("zp_vip_aura_radius", "20")
	pCvarPSF = register_cvar("zp_vip_painshockfree", "1")
	pCvarModelIndex = register_cvar("zp_vip_modelindex", "0")
	
	register_message(get_user_msgid("CurWeapon"), "message_CurWeapon")
	
	register_event("HLTV", "event_new_round", "a", "1=0", "2=0")
	register_event("CurWeapon", "event_CurWeapon", "be", "1=1")
	
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_Killed_Post", 1)
	RegisterHam(Ham_Touch, "weaponbox", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "armoury_entity", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "weapon_shield", "fw_TouchWeapon")
	
	gMsgDeathMsg = get_user_msgid("DeathMsg")
	gMsgScoreInfo = get_user_msgid("ScoreInfo")
	
	MaxPlayers = get_maxplayers()
	
	gFwVIPround = CreateMultiForward("zp_round_is_vip", ET_IGNORE)
}

public plugin_precache()
{
	new buffer[200]
	formatex(buffer, charsmax(buffer), "models/player/%s/%s.mdl", VIP_MODEL, VIP_MODEL)
	precache_model(buffer)
	
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Pre")
}

public plugin_natives()
{
	register_native("zp_is_user_vip", "_zp_is_user_vip", 0)
}

public client_putinserver(id)
{
	MarkUserConnected(id)
}

public client_disconnect(id)
{
	if(!cToggle)
		return PLUGIN_HANDLED
	
	if(IsUserVIP(id) && gSwarmPlague)
	{
		ClearUserVIP(id)
		
		new health = get_user_health(id)
		new armor = get_user_armor(id)
		new szNameOldVIP[32]; get_user_name(id, szNameOldVIP, charsmax(szNameOldVIP))
		
		static iPlayersNum
		iPlayersNum = fnGetAliveCTs()
		
		id = fnGetRandomAliveCTs(random_num(1, iPlayersNum))
		
		if(IsUserAlive(id))
		{
			new szNameNewVIP[32]
			
			MarkUserVIP(id)
			
			get_user_name(id, szNameNewVIP, charsmax(szNameNewVIP))
				
			set_hudmessage(255, 0, 0, 0.0, -1.0, 0, 6.0, 5.0)
			show_hudmessage(0, "%s este noul presedinte!!", szNameNewVIP)
			
			client_print(0, print_chat, "[ZP] Presedintele %s s-a deconectat, %s este nou presedinte.", szNameOldVIP, szNameNewVIP)
			
			set_user_health(id, health)
			set_user_armor(id, armor) // cs_set_user_armor is useless for ZP
			set_user_gravity(id, cGravity)
			
			cs_set_user_model(id, VIP_MODEL)
			
			set_task(0.1, "vip_aura", id + TASK_AURA, _, _, "b")
			
			new szColor[12], szRed[4], szGreen[4], szBlue[4]
			get_pcvar_string(pCvarGlow, szColor, 11)
			parse(szColor, szRed, 3, szGreen, 3, szBlue, 4)
	
			new iRed = clamp(str_to_num(szRed), 0, 255)
			new iGreen = clamp(str_to_num(szGreen), 0, 255)
			new iBlue = clamp(str_to_num(szBlue) , 0, 255)
			
			if(iRed == -1 || iGreen == - 1 || iBlue == -1)
				return PLUGIN_HANDLED
				
			if(pev_valid(id))
				set_user_rendering(id, kRenderFxGlowShell, iRed, iGreen, iBlue, kRenderNormal, 5)
		}
	}
	return PLUGIN_HANDLED
}

public event_new_round()
{
	cToggle = get_pcvar_num(pCvarToggle)
	cMode = get_pcvar_num(pCvarMode)
	cRewardZ = get_pcvar_num(pCvarRewardZ)
	cRewardH = get_pcvar_num(pCvarRewardH)
	cRewardV = get_pcvar_num(pCvarRewardV)
	cHealth = get_pcvar_num(pCvarHealth)
	cExtraHealth = get_pcvar_num(pCvarExtraHealth)
	cArmor = get_pcvar_num(pCvarArmor)
	cGravity = get_pcvar_float(pCvarGravity)
	cUClip = get_pcvar_num(pCvarUClip)
	cPickup = get_pcvar_num(pCvarPickup)
	cRespawnZombie = get_pcvar_num(pCvarRespawnZombie)
	cRespawnDelay = get_pcvar_float(pCvarRespawnDelay)
	cAuraRadius = get_pcvar_num(pCvarAuraRadius)
	cPSF = get_pcvar_num(pCvarPSF)
	cModelIndex = get_pcvar_num(pCvarModelIndex)
	
	if(gSwarmPlague)
	{
		set_msg_block(gMsgDeathMsg, BLOCK_NOT)
		set_msg_block(gMsgScoreInfo, BLOCK_NOT)
		
		gSwarmPlague = false
	}
}

public event_CurWeapon(id)
{
	if(IsUserConnected(id) && IsUserVIP(id) && cToggle && !cPickup)
	{
		gCurWeapon[id] = read_data(2)
		
		if(gCurWeapon[id] != CSW_KNIFE)
		{
			engclient_cmd(id, "weapon_knife")
		}
	}
}

public fw_TakeDamage_Pre(victim, inflictor, attacker, Float:damage, damagetype)
{
	if(IsUserConnected(attacker) && cToggle && gSwarmPlague)
	{
		if(IsUserZombie(attacker) && IsUserVIP(victim))
		{
			ExecuteHam(Ham_TakeDamage, victim, inflictor, attacker, Float:damage, damagetype)
			return HAM_SUPERCEDE
		}
	}
	return HAM_IGNORED
}

public fw_PlayerSpawn_Post(id)
{
	if(is_user_alive(id))
	{
		MarkUserAlive(id)
		ClearUserVIP(id)
		
		if(zp_get_user_zombie(id))
			MarkUserZombie(id)
		else
			ClearUserZombie(id)
	}
}

public fw_TakeDamage_Post(victim, inflictor, attacker)
{
	// Fix a bug where server crashes if the entity pvData is not yet initalized
	if(pev_valid(victim) != PDATA_SAFE)
		return
		
	if(cPSF)
		set_pdata_float(victim, OFFSET_PAINSHOCK, 1.0, OFFSET_LINUX)
}

public fw_Killed_Post(victim, attacker)
{
	if(!cToggle)
		return PLUGIN_HANDLED
	
	if(cRespawnZombie && IsUserZombie(victim) && gSwarmPlague)
	{
		set_task(cRespawnDelay, "respawn_zombie", victim)
	}
	
	if(IsUserVIP(victim) && gSwarmPlague)
	{
		ClearUserVIP(victim)
		
		new szName[32]
		
		get_user_name(attacker, szName, charsmax(szName))
		
		set_hudmessage(255, 0, 0, 0.0, -1.0, 0, 6.0, 5.0)
		show_hudmessage(0, "The VIP was killed by %s!!", szName)
		
		client_print(0, print_chat, "[ZP] The VIP was killed by %s!!", szName)
		
		for(new i = 1; i <= MaxPlayers; i++)
		{	
			set_user_rendering(victim)
			
			if(IsUserZombie(i))
			{
				zp_set_user_ammo_packs(i, zp_get_user_ammo_packs(i) + cRewardZ)
				client_print(i, print_chat, "Ai primit %d euro pentru terminarea misiunii cu succes.", cRewardZ)
			}
			else
			{
				client_print(i, print_chat, "[ZP] Ai pierdut...Nu ai putut sa aperi presedintele.")
				
				set_msg_block(gMsgDeathMsg, BLOCK_ONCE)
				set_msg_block(gMsgScoreInfo, BLOCK_ONCE)
				
				user_silentkill(i)
			}
		}
	}
	return HAM_IGNORED
}

public fw_TouchWeapon(weapon, id)
{
	if(IsUserConnected(id) && IsUserAlive(id) && IsUserVIP(id) && !cPickup && cToggle)
		return HAM_SUPERCEDE
	
	return HAM_IGNORED
}

public vip_aura(taskid)
{
	if(IsUserVIP(ID_AURA) && IsUserAlive(ID_AURA) && IsUserConnected(ID_AURA))
	{
		new szColor[12], szRed[4], szGreen[4], szBlue[4]
		get_pcvar_string(pCvarAura, szColor, 11)
		parse(szColor, szRed, 3, szGreen, 3, szBlue, 4)
		
		new iRed = clamp(str_to_num(szRed), 0, 255)
		new iGreen = clamp(str_to_num(szGreen), 0, 255)
		new iBlue = clamp(str_to_num(szBlue) , 0, 255)
		
		if(iRed == -1 || iGreen == - 1 || iBlue == -1)
		{
			remove_task(taskid)
			return
		}
		
		static origin[3]
		get_user_origin(ID_AURA, origin)
		
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_DLIGHT)
		write_coord(origin[0])
		write_coord(origin[1])
		write_coord(origin[2]) 
		write_byte(cAuraRadius)
		write_byte(iRed)
		write_byte(iGreen)
		write_byte(iBlue)
		write_byte(2)
		write_byte(0)
		message_end()
	}
	else
	{
		remove_task(taskid)
		return
	}
}

public message_CurWeapon(msg_id, msg_dest, msg_entity)
{
	if(IsUserZombie(msg_entity))
		return
		
	if(IsUserAlive(msg_entity) && IsUserVIP(msg_entity))
	{
		if(get_msg_arg_int(1) != 1)
			return
			
		if(!cUClip)
			return
			
		static weapon
		weapon = get_msg_arg_int(2)
		
		if(MAXBPAMMO[weapon] > 2)
		{
			cs_set_weapon_ammo(get_pdata_cbase(msg_entity, OFFSET_ACTIVE_ITEM, OFFSET_LINUX), MAXCLIP[weapon])
			
			set_msg_arg_int(3, get_msg_argtype(3), MAXCLIP[weapon])
		}
	}
}

public zp_user_infected_post(id)
{
	MarkUserZombie(id)
}

public zp_round_started(gamemode, id)
{
	if(!cToggle || fnGetAlive() < 4)
		return PLUGIN_HANDLED
		
	if(gamemode == MODE_SWARM && cMode || gamemode == MODE_PLAGUE && !cMode)
	{
		gSwarmPlague = true
		
		ExecuteForward(gFwVIPround, gFwDummyResult)
		
		new szName[32]
		
		static iPlayersNum
		iPlayersNum = fnGetAliveCTs()
		
		id = fnGetRandomAliveCTs(random_num(1, iPlayersNum))
		
		if(IsUserAlive(id))
		{
			MarkUserVIP(id)
			
			get_user_name(id, szName, charsmax(szName))
			
			set_hudmessage(255, 0, 0, 0.0, -1.0, 0, 6.0, 5.0)
			show_hudmessage(0, "%s is the VIP!!", szName)
			
			client_print(0, print_chat, "[ZP] Protejeaza presedintele.")
			
			set_user_health(id, cHealth)
			set_user_armor(id, cArmor) // cs_set_user_armor is useless for ZP
			set_user_gravity(id, cGravity)
			
			cs_set_user_model(id, VIP_MODEL)
			
			set_task(0.1, "vip_aura", id + TASK_AURA, _, _, "b")
				
			new szColor[12], szRed[4], szGreen[4], szBlue[4]
			get_pcvar_string(pCvarGlow, szColor, 11)
			parse(szColor, szRed, 3, szGreen, 3, szBlue, 4)
	
			new iRed = clamp(str_to_num(szRed), 0, 255)
			new iGreen = clamp(str_to_num(szGreen), 0, 255)
			new iBlue = clamp(str_to_num(szBlue) , 0, 255)
			
			if(iRed == -1 || iGreen == - 1 || iBlue == -1)
				return PLUGIN_HANDLED
				
			if(pev_valid(id))
				set_user_rendering(id, kRenderFxGlowShell, iRed, iGreen, iBlue, kRenderNormal, 5)
		}
	}
	return PLUGIN_HANDLED
}

public zp_user_last_human(id)
{
	if(IsUserAlive(id) && IsUserVIP(id))
	{
		set_user_health(id, get_user_health(id) + cExtraHealth)
	}
}

public zp_round_ended(winteam)
{
	if(winteam == WIN_HUMANS && cToggle && gSwarmPlague)
	{
		for(new i = 1; i <= MaxPlayers; i++)
		{
			if(IsUserZombie(i))
			{
				set_msg_block(gMsgDeathMsg, BLOCK_SET)
				set_msg_block(gMsgScoreInfo, BLOCK_SET)
				
				user_silentkill(i)
				
				client_print(i, print_chat, "[ZP] Nu ai reusit sa omore presedintele... Misiune pierduta.")
			}
			else
			{
				new reward
				new ammopacks = zp_get_user_ammo_packs(i)
				
				if(IsUserVIP(i))
				{
					reward = cRewardH + cRewardV
					zp_set_user_ammo_packs(i, ammopacks + reward)
					client_print(i, print_chat, "Domnule presedinte ati primit %d euro pentru supravietuire.", reward)
				}
				else
				{
					reward = cRewardH
					zp_set_user_ammo_packs(i, ammopacks + reward)
					client_print(i, print_chat, "Ai primit %d euro pentru salvarea presedintelui.", reward)
				}
			}
		}
	}
	return PLUGIN_HANDLED
}

public zp_user_infect_attempt(victim, infector, nemesis)
{
	// Non-player infection or turned into a nemesis
	if(!infector || nemesis || !cToggle)	
		return PLUGIN_CONTINUE
		
	if(IsUserVIP(victim))
	{
		if(zp_get_user_infection_nade(infector) > 0)
			return ZP_PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}

public respawn_zombie(id)
{
	if(IsUserAlive(id))
		return
		
	if(cToggle && cRespawnZombie && IsUserConnected(id))
	{
		zp_respawn_user(id, ZP_TEAM_ZOMBIE)
	}
}

fnGetAliveCTs()
{
	static iAlive, id
	iAlive = 0
	
	for(id = 1; id <= MaxPlayers; id++)
	{
		if(IsUserAlive(id) && !zp_get_user_zombie(id))
			iAlive++
	}
	return iAlive
}

fnGetRandomAliveCTs(n)
{
	static iAlive, id
	iAlive = 0
	
	for(id = 1; id <= MaxPlayers; id++)
	{
		if(IsUserAlive(id) && !zp_get_user_zombie(id))
			iAlive++
		
		if(iAlive == n)
			return id
	}
	return -1
}

fnGetAlive()
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= MaxPlayers; id++)
	{
		if(IsUserAlive(id))
			iAlive++
	}
	return iAlive
}

// Native: zp_is_user_vip(id)
public _zp_is_user_vip(id)
{
	if(!cToggle)
		return -1
	
	return IsUserVIP(id)
}

// zp_get_user_infection_nade credits: meTaLiCroSS & me(changing to FM)
stock zp_get_user_infection_nade(id)
{
	static iNade
	iNade = fm_get_grenade_id(id, "", 0)
	
	if(iNade > 0 && pev_valid(iNade) 
	&& zp_get_grenade_type(iNade) == NADE_TYPE_INFECTION)	
		return iNade
	
	return 0
}

stock fm_find_ent_by_owner(index, const classname[], owner, jghgtype = 0)
{
	new strtype[11] = "classname", ent = index
	
	switch (jghgtype)
	{
		case 1: strtype = "target"
		case 2: strtype = "targetname"
	}
	
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, strtype, classname)) && pev(ent, pev_owner) != owner) {}
	
	return ent
}

stock fm_get_grenade_id(id, model[], len, grenadeid = 0)
{
	new ent = fm_find_ent_by_owner(grenadeid, "grenade", id)
	if (ent && len > 0)
		pev(ent, pev_model, model, len)

	return ent
}
