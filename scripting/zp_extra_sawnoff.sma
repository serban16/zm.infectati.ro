#include <amxmodx>
#include <fakemeta_util>
#include <hamsandwich>
#include <zombieplague>

/*================================================================================
 [Customization]
=================================================================================*/

// Item Cost
new const g_SawnOff_Cost = 30

// Models
new const sawnoff_model_v[] = "models/v_sawn_off_shotgun.mdl"
new const sawnoff_model_p[] = "models/p_sawn_off_shotgun.mdl"
new const sawnoff_model_w[] = "models/w_sawn_off_shotgun.mdl"

// ---------------------------------------------------------------
// ------------------ Customization ends here!! ------------------
// ---------------------------------------------------------------

// Offsets
#if cellbits == 32
const OFFSET_CLIPAMMO = 51
#else
const OFFSET_CLIPAMMO = 65
#endif
const OFFSET_LINUX = 5
const OFFSET_LINUX_WEAPONS = 4
const OFFSET_LASTPRIMARYITEM = 368

// Version
#define VERSION "0.3"

// Arrays
new g_sawnoff_shotgun[33], g_currentweapon[33]

// Variables
new g_SawnOff, g_MaxPlayers

// Cvar Pointers
new cvar_enable, cvar_oneround, cvar_knockback, cvar_knockbackpower, cvar_uclip, cvar_damage

/*================================================================================
 [Init and Precache]
=================================================================================*/

public plugin_init() 
{
	// Plugin Info
	register_plugin("[ZP] Extra Item: Sawn-Off Shotgun", VERSION, "meTaLiCroSS")
	
	// Ham Forwards
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	RegisterHam(Ham_TraceAttack, "player", "fw_TraceAttack")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	
	// Fakemeta Forwards
	register_forward(FM_SetModel, "fw_SetModel")
	register_forward(FM_Touch, "fw_Touch")
	
	// Event: Round Start
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	
	// Message: Cur Weapon
	register_message(get_user_msgid("CurWeapon"), "message_cur_weapon")
	
	// CVARS
	register_cvar("zp_extra_sawnoff", VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	cvar_enable = register_cvar("zp_sawnoff_enable", "1")
	cvar_uclip = register_cvar("zp_sawnoff_unlimited_clip", "1")
	cvar_damage = register_cvar("zp_sawnoff_damage_mult", "3.5")
	cvar_oneround = register_cvar("zp_sawnoff_oneround", "1")
	cvar_knockback = register_cvar("zp_sawnoff_knockback", "1")
	cvar_knockbackpower = register_cvar("zp_sawnoff_kbackpower", "10.0")
	
	// Variables
	g_MaxPlayers = get_maxplayers()
	g_SawnOff = zp_register_extra_item("Western Shotgun(o runda)", g_SawnOff_Cost, ZP_TEAM_HUMAN)
	
}

public plugin_precache()
{
	// Precaching models
	engfunc(EngFunc_PrecacheModel, sawnoff_model_v)
	engfunc(EngFunc_PrecacheModel, sawnoff_model_p)
	engfunc(EngFunc_PrecacheModel, sawnoff_model_w)
}

/*================================================================================
 [Main Functions]
=================================================================================*/

// Round Start Event
public event_round_start()
{
	// Get all the players
	for(new id = 1; id <= g_MaxPlayers; id++)
	{
		// Check
		if(get_pcvar_num(cvar_oneround) || !get_pcvar_num(cvar_enable))
		{
			// Striping Sawn Off
			if(g_sawnoff_shotgun[id])
			{
				g_sawnoff_shotgun[id] = false;
				fm_strip_user_gun(id, CSW_M3)
			}
		}
	}
}

// Message Current Weapon
public message_cur_weapon(msg_id, msg_dest, id)
{
	// Doesn't have a Sawn Off
	if (!g_sawnoff_shotgun[id])
		return PLUGIN_CONTINUE
	
	// Isn't alive / not active weapon
	if (!is_user_alive(id) || get_msg_arg_int(1) != 1)
		return PLUGIN_CONTINUE
		
	// Get Weapon Clip
	new  clip = get_msg_arg_int(3)
	
	// Update Weapon Array
	g_currentweapon[id] = get_msg_arg_int(2) // get weapon ID
	
	// Weapon isn't M3
	if(g_currentweapon[id] != CSW_M3)
		return PLUGIN_CONTINUE;
		
	// Replace Models
	sawnoff_models(id)
	
	// Check cvar
	if(get_pcvar_num(cvar_uclip))
	{	
		// Set Ammo HUD in 8
		set_msg_arg_int(3, get_msg_argtype(3), 8)
			
		// Check clip if more than 2
		if (clip < 2)
		{
			// Update weapon ammo
			new weapon_ent = fm_find_ent_by_owner(-1, "weapon_m3", id)
	
			fm_set_weapon_ammo(weapon_ent, 8)
		}
	}
	
	return PLUGIN_CONTINUE;
}

// Touch fix (when user drop the Sawn off, already has the Sawn off.
public touch_fix(id)
{
	if(g_sawnoff_shotgun[id])
		g_sawnoff_shotgun[id] = false;
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

public fw_PlayerKilled(victim, attacker, shouldgib)
{
	// Victim has a Sawn off
	if(g_sawnoff_shotgun[victim])
	{
		g_sawnoff_shotgun[victim] = false;
	}
}

public fw_SetModel(entity, model[])
{
	// Entity is not valid
	if(!pev_valid(entity))
		return FMRES_IGNORED;
		
	// Entity model is not a M3
	if(!equali(model, "models/w_m3.mdl")) 
		return FMRES_IGNORED;
		
	// Get owner and entity classname
	new owner = pev(entity, pev_owner)
	new classname[33]; pev(entity, pev_classname, classname, charsmax(classname))
	
	// Entity classname is a weaponbox
	if(equal(classname, "weaponbox"))
	{
		// The weapon owner has a Sawn Off
		if(g_sawnoff_shotgun[owner])
		{
			// Striping Sawn off and set New Model
			g_sawnoff_shotgun[owner] = false;
			engfunc(EngFunc_SetModel, entity, sawnoff_model_w)
			
			// client_print(0, print_chat, "model test")
			
			set_task(0.1, "touch_fix", owner)
			
			return FMRES_SUPERCEDE
		}
	}
	
	return FMRES_IGNORED

}

public fw_Touch(entity, toucher)
{
	// Entity is not valid
	if(!pev_valid(entity) || !pev_valid(toucher))
		return FMRES_IGNORED;
		
	// Get model, toucher classname, and entity classname
	new model[33], toucherclass[33], entityclass[33]
	pev(entity, pev_model, model, charsmax(model))
	pev(entity, pev_classname, entityclass, charsmax(entityclass))
	pev(toucher, pev_classname, toucherclass, charsmax(toucherclass))
	
	// Toucher isn't a Player // Entity isn't a Weapon
	if(!equali(toucherclass, "player") || !equali(entityclass, "weaponbox"))
		return FMRES_IGNORED;
		
	// Check Model
	if(equali(model, sawnoff_model_w))
	{
		// Player is allowed to pickup the weapon
		if(allowed_touch(toucher))
		{
			// Set Weapon
			g_sawnoff_shotgun[toucher] = true;
			// client_print(0, print_chat, "touch test")
		}
	}
	
	return FMRES_IGNORED;
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	// Doesn't have a Sawn Off / Attacker's weapon isn't a M3 // Victim is Human
	if( ! ( 1<= victim <= get_maxplayers() ) || ! ( 1<= attacker <= get_maxplayers() )) return HAM_IGNORED;
	if(!g_sawnoff_shotgun[attacker] || g_currentweapon[attacker] != CSW_M3 || !zp_get_user_zombie(victim) || !(1 <= attacker <= g_MaxPlayers))
		return HAM_IGNORED;
		
	SetHamParamFloat(4, (damage *= get_pcvar_float(cvar_damage)) )
	
	return HAM_IGNORED;
}

public fw_TraceAttack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type)
{
	if (!(1 <= attacker <= g_MaxPlayers))
		return HAM_IGNORED;

	// Player is allowed to make a Knockback
	if(!allowed_knockback(victim, attacker))
		return HAM_IGNORED;
		
	// Check damage type
	if(!(damage_type & DMG_BULLET))
		return HAM_IGNORED;
		
	new Float:velocity[3]; pev(victim, pev_velocity, velocity)
	 
	xs_vec_mul_scalar(direction, get_pcvar_float(cvar_knockbackpower), direction)
	 
	xs_vec_add(velocity, direction, direction)
		 
	set_pev(victim, pev_velocity, direction)
		 
	return HAM_IGNORED;
 
}

/*================================================================================
 [Internal Functions]
=================================================================================*/

sawnoff_models(id)
{
	// Weapon isn't M3 / Alive... / Doesn't have a Sawn Off
	if(g_currentweapon[id] != CSW_M3 || !is_user_alive(id) || !g_sawnoff_shotgun[id])
		return PLUGIN_CONTINUE;
		
	// Set Models
	set_pev(id, pev_viewmodel2, sawnoff_model_v)
	set_pev(id, pev_weaponmodel2, sawnoff_model_p)
	
	return PLUGIN_CONTINUE;
}

allowed_knockback(victim, attacker)
{
	if(!g_sawnoff_shotgun[attacker] || !get_pcvar_num(cvar_knockback) || g_currentweapon[attacker] != CSW_M3 || !zp_get_user_zombie(victim))
		return false;
	
	return true;
}

allowed_touch(toucher)
{
	if(zp_get_user_survivor(toucher) || zp_get_user_zombie(toucher) || fm_get_user_lastprimaryitem(toucher) || g_sawnoff_shotgun[toucher])
		return false;
		
	return true;
}

/*================================================================================
 [Zombie Plague Forwards]
=================================================================================*/

public zp_extra_item_selected(id, itemid)
{
	if(itemid == g_SawnOff)
	{
		if(!get_pcvar_num(cvar_enable))
		{
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + g_SawnOff_Cost)
			client_print(id, print_chat, "[ZP] The Sawn-Off Shotgun is Disabled")
			
			return;
		}
		
		if(g_sawnoff_shotgun[id] && user_has_weapon(id, CSW_M3))
		{
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + g_SawnOff_Cost)
			client_print(id, print_chat, "[ZP] You already have a Sawn-Off Shotgun")
			
			return;
		}
		
		g_sawnoff_shotgun[id] = true
		
		fm_give_item(id, "weapon_m3")
		
		for(new i = 0; i <= 5; i++)
			fm_give_item(id, "ammo_buckshot")

		client_print(id, print_chat, "[ZP] You now have a Sawn-Off Shotgun")
		
	}
}

public zp_user_infected_post(infected, infector)
{
	if(g_sawnoff_shotgun[infected])
		g_sawnoff_shotgun[infected] = false;
}

public zp_user_humanized_post(player)
{
	if(zp_get_user_survivor(player) && g_sawnoff_shotgun[player])
		g_sawnoff_shotgun[player] = false;
}

/*================================================================================
 [Stocks]
=================================================================================*/

stock fm_set_weapon_ammo(entity, amount)
{
	set_pdata_int(entity, OFFSET_CLIPAMMO, amount, OFFSET_LINUX_WEAPONS);
}

stock fm_get_user_lastprimaryitem(id) // Thanks to joaquimandrade
{
	if(get_pdata_cbase(id, OFFSET_LASTPRIMARYITEM) != -1)
		return true;
		
	return false;
}
