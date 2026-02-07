/*================================================================================
	
	--------------------------------
	-*- [ZP] Extra Items Example -*-
	--------------------------------
	
	~~~~~~~~~~~~~~~
	- Description -
	~~~~~~~~~~~~~~~
	
	This is just an example on how to add additional extra items to ZP.
	
================================================================================*/

#include <amxmodx>
#include <zombieplague>
#include <fakemeta>
#include <weaponmod>

// Item IDs
new g_itemid1

public plugin_initialize()
{
	register_plugin("[ZP] Extra Item: Gravity Gun", "1.0", "DevconeS & jiribocek")
	
	// Register the new items and store their IDs for future reference
	g_itemid1 = zp_register_extra_item("Gravity Gun", 25, ZP_TEAM_HUMAN) // Humans only
}

// Item Selected forward
public zp_extra_item_selected(player, itemid)
{
	// Check if the selected item matches any of our registered ones
	if (itemid == g_itemid1)
		client_print(player, print_chat, "[ZP] You purchased GGun. Have fun.")
}

// Plugin information
new PLUGIN[] = "[ZP] Extra Item: Gravity Gun"
new VERSION[] = "0.6"
new AUTHOR[] = "DevconeS and jiribocek"

// Weapon information
new WPN_NAME[] = "Gravity Gun"
new WPN_SHORT[] = "gravitygun"

// Models
new P_MODEL[] = "models/zombie_plague/p_ggun.mdl"
new V_MODEL[] = "models/zombie_plague/v_ggun.mdl"
new W_MODEL[] = "models/zombie_plague/w_ggun.mdl"

// GravitGun Power
#define MAX_DISTANCE	1000
#define GRAB_WIDTH		100
#define THROW_WIDTH		1000
#define GRAB_STRENGTH	20
#define TAKE_SPEED		500

#define BATTERY_USAGE	0.4

// Sequences
enum
{
	anim_idle,
	anim_idle2,
	anim_fidget,
	anim_spinup,
	anim_spin,
	anim_fire,
	anim_fire2,
	anim_holster,
	anim_draw
}

new g_wpnid
new g_Grabbed[33]
new g_Thrown[33]
new g_UserHealth[33]
new Float:g_nextUpdate[33]

new g_msgDeathMsg
new g_msgScoreInfo
new g_msgHealth

new g_FriendlyFire
new g_MaxPlayers

// Precache required files
public plugin_precache()
{
	precache_model(P_MODEL)
	precache_model(V_MODEL)
	precache_model(W_MODEL)
}

// Initialize plugin
public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
	g_msgHealth = get_user_msgid("Health")
	
	register_message(g_msgDeathMsg, "msgDeathMsg")
	register_message(g_msgHealth, "msgHealth")
	
	g_FriendlyFire = get_cvar_pointer("wpn_friendlyfire")
	g_MaxPlayers = get_maxplayers()
	
	register_forward(FM_StartFrame, "fwd_StartFrame")
	
	create_weapon()
}

// Used to hack the DeathMsg information
public msgDeathMsg()
{
	new attacker = get_msg_arg_int(1)
	if(!attacker)
	{
		// No attacker given, so it could be done using the GravityGun
		new victim = get_msg_arg_int(2)
		for(new i = 1; i < g_MaxPlayers; i++)
		{
			if(i != victim && (g_Grabbed[i] == victim || g_Thrown[i] == victim))
			{
				// We found someone who's grabbed the victim which died right now, so modify this message
				set_msg_arg_int(1, ARG_BYTE, i)	// killer id
				set_msg_arg_string(4, WPN_SHORT)	// weapon name
				
				// Update player's frags
				new Float:frags
				pev(i, pev_frags, frags)
				if(get_user_team(i) != get_user_team(victim))
					frags++
				else if(get_user_team(i) == get_user_team(victim))
					frags--
				set_pev(i, pev_frags, frags)
				
				// Attacker's Score
				message_begin(MSG_BROADCAST, g_msgScoreInfo)
				write_byte(i)
				write_short(floatround(frags))
				write_short(wpn_gi_get_offset_int(i, offset_deaths))
				write_short(0)
				write_short(1)
				message_end()
				
				// Victim's Score
				pev(victim, pev_frags, frags)
				
				message_begin(MSG_BROADCAST, g_msgScoreInfo)
				write_byte(victim)
				write_short(floatround(frags))
				write_short(wpn_gi_get_offset_int(victim, offset_deaths))
				write_short(0)
				write_short(1)
				message_end()
				
				// Play idle animation and reset grab
				wpn_playanim(i, random_num(anim_idle, anim_idle2))
				
				g_Grabbed[i] = 0
				g_Thrown[i]= 0
			}
		}
		
	} else if(g_Grabbed[attacker])
	{
		g_Grabbed[attacker] = 0
	}
}

// Called each time damage was caused
public msgHealth(msg_id, msg_dest, entity)
{
	new attacker = get_user_attacker(entity)
	new health = get_msg_arg_int(1)
	
	// No attacker
	if(health != g_UserHealth[entity] && (attacker == entity || attacker == 0))
	{
		for(new i = 1; i < g_MaxPlayers; i++)
		{
			if(i != entity && (g_Grabbed[i] == entity || g_Thrown[i] == entity))
			{
				// We found the grabber/thrower of the player
				if(!get_pcvar_num(g_FriendlyFire) && get_user_team(entity) == get_user_team(i))
				{
					// Friendly fire disabled, restore health
					set_pev(entity, pev_health, float(g_UserHealth[entity]))
					return PLUGIN_HANDLED
				}
			}
		}
	}
	
	g_UserHealth[entity] = health
	return PLUGIN_CONTINUE
}

// Reest grab
public client_connect(id)
	g_Grabbed[id] = 0

// Register weapon to WeaponMod
create_weapon()
{
	new wpnid = wpn_register_weapon(WPN_NAME, WPN_SHORT)
	if(wpnid == -1) return PLUGIN_CONTINUE
	
	// Strings
	wpn_set_string(wpnid, wpn_viewmodel, V_MODEL)
	wpn_set_string(wpnid, wpn_weaponmodel, P_MODEL)
	wpn_set_string(wpnid, wpn_worldmodel, W_MODEL)
	
	// Event handlers
	wpn_register_event(wpnid, event_attack1, "ev_attack1")
	wpn_register_event(wpnid, event_attack2, "ev_attack2")
	wpn_register_event(wpnid, event_reload, "ev_reload")
	wpn_register_event(wpnid, event_draw, "ev_draw")
	wpn_register_event(wpnid, event_hide, "ev_hide")
	wpn_register_event(wpnid, event_weapondrop, "ev_weapondrop")
	
	// Floats
	wpn_set_float(wpnid, wpn_refire_rate1, 1.0)
	wpn_set_float(wpnid, wpn_refire_rate2, 1.0)
	wpn_set_float(wpnid, wpn_reload_time, 3.0)
	wpn_set_float(wpnid, wpn_recoil1, 5.0)
	wpn_set_float(wpnid, wpn_run_speed, 250.0)
	
	// Integers
	wpn_set_integer(wpnid, wpn_ammo1, 100)
	wpn_set_integer(wpnid, wpn_ammo2, 200)
	wpn_set_integer(wpnid, wpn_bullets_per_shot1, 5)
	wpn_set_integer(wpnid, wpn_bullets_per_shot2, 1)
	wpn_set_integer(wpnid, wpn_cost, 6000)
	
	g_wpnid = wpnid
	return PLUGIN_CONTINUE
}

// Attack 1 (throw)
public ev_attack1(id)
{
	// Play animation
	wpn_playanim(id, anim_fire2)
	new ent
	if(!pev_valid(g_Grabbed[id]))
	{
		// Player didn't grab anything, try to find an entity in his view direction to throw
		new Float:fStart[3], Float:fEnd[3], Float:fVel[3], res
		pev(id, pev_origin, fStart)
		velocity_by_aim(id, MAX_DISTANCE, fVel)
		
		fEnd[0] = fStart[0]+fVel[0]
		fEnd[1] = fStart[1]+fVel[1]
		fEnd[2] = fStart[2]+fVel[2]
		
		// Draw traceline and check if an entity was hit
		engfunc(EngFunc_TraceLine, fStart, fEnd, 0, id, res)
		ent = get_tr2(res, TR_pHit)
		if(!pev_valid(ent)) return PLUGIN_CONTINUE
	} else {
		// Entity was grabbed
		ent = g_Grabbed[id]
	}
	
	// Throw the entity
	new Float:fVel[3]
	velocity_by_aim(id, THROW_WIDTH, fVel)
	set_pev(ent, pev_velocity, fVel)
	g_Thrown[id] = ent
	g_Grabbed[id] = 0
	
	return PLUGIN_CONTINUE
}

// Attack 2 (grab)
public ev_attack2(id)
{
	// Remove grabbed entity if it's invalid
	if(!pev_valid(g_Grabbed[id])) g_Grabbed[id] = 0
	
	if(g_Grabbed[id])
	{
		// Entity was grabbed, release it
		wpn_playanim(id, anim_fire2)
		g_Grabbed[id] = 0
		return PLUGIN_CONTINUE
	}
	
	new usrwpn = wpn_has_weapon(id, g_wpnid)
	new ammo = wpn_get_userinfo(id, usr_wpn_ammo1, usrwpn)
	if(ammo > 0)
	{
		// User has ammo, try to grab an entity in player's view direction
		new Float:fStart[3], Float:fEnd[3], Float:fVel[3], res
		pev(id, pev_origin, fStart)
		velocity_by_aim(id, MAX_DISTANCE, fVel)
		
		fEnd[0] = fStart[0]+fVel[0]
		fEnd[1] = fStart[1]+fVel[1]
		fEnd[2] = fStart[2]+fVel[2]
		
		// Draw traceline and check if a player was hit
		engfunc(EngFunc_TraceLine, fStart, fEnd, 0, id, res)
		new ent = get_tr2(res, TR_pHit)
		if(pev_valid(ent))
		{
			// Entity found
			if(pev(ent, pev_flags) & (FL_CLIENT | FL_FAKECLIENT | FL_MONSTER))
			{
				// Player/monster found, grab target
				g_Grabbed[id] = ent
				set_Velocity(id, GRAB_WIDTH, TAKE_SPEED)
				g_nextUpdate[id] = get_gametime()+BATTERY_USAGE	
				wpn_playanim(id, anim_spinup)
			}
		} else {
			// No player/monster grabbed
			wpn_playanim(id, anim_fire2)
		}
	}else if(wpn_get_userinfo(id, usr_wpn_ammo2, usrwpn) > 0)
	{
		// No primary ammo, but secondary is available, reload weapon and release grabbed entity
		wpn_reload_weapon(id)
		g_Grabbed[id] = 0
	}
	
	return PLUGIN_CONTINUE
}

// Weapon reloads
public ev_reload(id)
{
	g_Grabbed[id] = 0
	wpn_playanim(id, anim_fidget)
}

// Weapon drawed
public ev_draw(id)
	wpn_playanim(id, anim_draw)

// Weapon hidden
public ev_hide(id)
	g_Grabbed[id] = 0

// Weapon dropped
public ev_weapondrop(id, entity)
	g_Grabbed[id] = 0

// Called everytime a new frame has started
public fwd_StartFrame()
{
	static id
	for(id = 1; id < 33; id++)
	{
		if(is_user_alive(id))
		{
			// Player is alive, do the actions
			client_think(id)
		}
	}
}

// Does actions to the player
public client_think(id)
{
	static usrwpn
	static ammo
	
	if(pev_valid(g_Grabbed[id]))
	{
		// Make sure the user grabbed a player/monster
		if(pev(g_Grabbed[id], pev_flags) & (FL_CLIENT | FL_FAKECLIENT | FL_MONSTER))
		{
			// User has grabbed a player/monster, get ammo
			usrwpn = wpn_has_weapon(id, g_wpnid)
			ammo = wpn_get_userinfo(id, usr_wpn_ammo1, usrwpn)
			
			if(ammo > 0)
			{
				// There is still some ammo remaining, move grabbed player/monster
				set_Velocity(id, GRAB_WIDTH, GRAB_STRENGTH)			
				if(g_nextUpdate[id] <= get_gametime())
				{
					// Decrease ammo
					wpn_set_userinfo(id, usr_wpn_ammo1, usrwpn, ammo-1)
					wpn_playanim(id, anim_spin)
					g_nextUpdate[id] = get_gametime()+BATTERY_USAGE
				}
			} else if(wpn_get_userinfo(id, usr_wpn_ammo2, usrwpn) > 0)
			{
				// No primary ammo available, but there's still some secondary, reload!
				wpn_reload_weapon(id)
				g_Grabbed[id] = 0
			}
		}
	}
	
	if(pev_valid(g_Thrown[id]))
	{
		if(pev(g_Thrown[id], pev_flags) & FL_ONGROUND)
		{
			// The player throw another player which is now on the floor, so he's not thrown anymore
			g_Thrown[id] = 0
		}
	}
}

// Sets the velocity of a player/entity
public set_Velocity(id, distance, speed)
{
	new Float:fOrigin[3], Float:eOrigin[3], Float:aOrigin[3], Float:fVel[3]
	pev(id, pev_origin, fOrigin)
	pev(g_Grabbed[id], pev_origin, eOrigin)
	velocity_by_aim(id, distance, fVel)
	
	aOrigin[0] = (fOrigin[0]+fVel[0]-eOrigin[0])*speed
	aOrigin[1] = (fOrigin[1]+fVel[1]-eOrigin[1])*speed
	aOrigin[2] = (fOrigin[2]+fVel[2]-eOrigin[2])*speed
	
	set_pev(g_Grabbed[id], pev_velocity, aOrigin)
}

