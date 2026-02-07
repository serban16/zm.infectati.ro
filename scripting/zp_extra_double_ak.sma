#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <cstrike>
#include <zombie_plague_advance>

#define is_valid_player(%1) (1 <= %1 <= 32)

new AK_V_MODEL[64] = "models/zombie_plague/v_ak47_dublu.mdl"
new AK_P_MODEL[64] = "models/zombie_plague/p_ak47_dublu.mdl"
new AK_W_MODEL[64] = "models/zombie_plague/w_ak47_dublu.mdl"

/* Pcvars */
new cvar_dmgmultiplier,  cvar_custommodel

// Item ID
new g_itemid

new bool:g_HasAk[33]
// Sprite
new m_spriteTexture

const Wep_ak47 = ((1<<CSW_AK47))

public plugin_init()
{
	
	/* CVARS */
	cvar_dmgmultiplier = register_cvar("zp_goldenak_dmg_multiplier", "2")
	cvar_custommodel = register_cvar("zp_goldenak_custom_model", "1")
	
	// Register The Plugin
	register_plugin("[ZP] Extra: Golden Ak 47", "1.1", "AlejandroSk")
	// Register Zombie Plague extra item
	g_itemid = zp_register_extra_item("AK47 Dubla (o runda)", 35, ZP_TEAM_HUMAN)
	// Death Msg
	register_event("DeathMsg", "Death", "a")
	// Weapon Pick Up
	register_event("WeapPickup","checkModel","b","1=19")
	// Current Weapon Event
	register_event("CurWeapon","checkWeapon","be","1=1")
	// Ham TakeDamage
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	RegisterHam(Ham_Spawn, "player", "fwHamPlayerSpawnPost", 1)
	
}

public client_connect(id)
{
	g_HasAk[id] = false
}

public client_disconnect(id)
{
	g_HasAk[id] = false
}

public Death()
{
	g_HasAk[read_data(2)] = false
}

public fwHamPlayerSpawnPost(id)
{
	g_HasAk[id] = false
}

public plugin_precache()
{
	precache_model(AK_V_MODEL)
	precache_model(AK_P_MODEL)
	precache_model(AK_W_MODEL)
	m_spriteTexture = precache_model("sprites/dot.spr")
	precache_sound("weapons/zoom.wav")
}

public zp_user_infected_post(id)
{
	if (zp_get_user_zombie(id))
	{
		g_HasAk[id] = false
	}
}

public checkModel(id)
{
	if ( zp_get_user_zombie(id) )
		return PLUGIN_HANDLED
	
	new szWeapID = read_data(2)
	
	if ( szWeapID == CSW_AK47 && g_HasAk[id] == true && get_pcvar_num(cvar_custommodel) )
	{
		set_pev(id, pev_viewmodel2, AK_V_MODEL)
		set_pev(id, pev_weaponmodel2, AK_P_MODEL)
	}
	return PLUGIN_HANDLED
}

public checkWeapon(id)
{
	new plrWeap[32]
	new plrWeapId
	
	plrWeapId = read_data(2)
	
	if (plrWeapId == CSW_AK47 && g_HasAk[id])
	{
		checkModel(id)
	}
	else 
	{
		return PLUGIN_CONTINUE
	}
	
	// If the user is out of ammo..
	get_weaponname(plrWeapId, plrWeap, 31)
	// Get the name of their weapon
	give_item(id, plrWeap)
	engclient_cmd(id, plrWeap) 
	engclient_cmd(id, plrWeap)
	engclient_cmd(id, plrWeap)

	return PLUGIN_HANDLED
}



public fw_TakeDamage(victim, inflictor, attacker, Float:damage)
{
    if ( is_user_connected(attacker) && is_valid_player( attacker ) && get_user_weapon(attacker) == CSW_AK47 && g_HasAk[attacker] )
    {
        SetHamParamFloat(4, damage * get_pcvar_float( cvar_dmgmultiplier ) )
    }
}

public zp_extra_item_selected(player, itemid)
{
	if ( itemid == g_itemid )
	{
		if ( user_has_weapon(player, CSW_AK47) )
		{
			drop_prim(player)
		}
		
		give_item(player, "weapon_ak47")
		g_HasAk[player] = true;
	}
}

stock drop_prim(id) 
{
	new weapons[32], num
	get_user_weapons(id, weapons, num)
	for (new i = 0; i < num; i++) {
		if (Wep_ak47 & (1<<weapons[i])) 
		{
			static wname[32]
			get_weaponname(weapons[i], wname, sizeof wname - 1)
			engclient_cmd(id, "drop", wname)
		}
	}
}