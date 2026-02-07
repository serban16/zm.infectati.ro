/*
	 Copyright © 2009, NiHiLaNTh

	Crossbow plugin is free software;
	you can redistribute it and/or modify it under the terms of the
	GNU General Public License as published by the Free Software Foundation.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with HeadShot Detection; if not, write to the
	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
	Boston, MA 02111-1307, USA.

	--- Intro ---
	   This is Crossbow from HL.It costs 25 Ammo packs(default).To attack press attack1
	button, to use zoom press attack2.If you shoot while zooming crossbow just hit enemy/
	wall, but if you are shooting without zoom bolt will explode and do more damage.
	You have 10 bolts in a clip and 25 in a back pack.
	
	--- Credits ---
	NiHiLaNTh - Plugin
	VEN - Finding weapon entities
	Arkshine - Ham_Item_Deploy/getting fov/weapon animation/Ammo
	meTaLiCroSS - Weapon touch/Weapon drop after death
	Scorpieo - Alternative crossbow model
	
	--- CVARs --- 
	zp_crossbow_damage 175 Damage done by explosion
	zp_crossbow_damage2 300 Damage done by bolt
	zp_crossbow_radius 175 Explosion radius
	zp_crossbow_one_round 1 // 1 - one round; 0 - until player got infected/killed
	zp_crossbow_knockback 10 // Knockback power
	
	--- Changelog ---
	v1.0 - First release
	v1.1 - Fixed bug where ammo was not updated correctly
	     - Optimized bolt flight
	     - Fixed crap runtime error
	v1.2 - Fixed some little bugs(ammo on zooming was not updated)
	v1.3 - Fixed bug with drop
	v1.4 - Fixed bug where player could reload infinite times
	     - Fixed bug with score info
	     - Added knockback from explosion
	v1.5 - Fixed bug where player were damaged and knockbacked, even he were not in radius     
	     - Fixed bug where player with godmode still could get damage
	     - Fixed bug where player could reload with full clip
	     - Fixed bug where player couldn't purchase crossbow after using antidote
	     - Added bleed stuff
	     - Added alternative model
	     - Fixed bug where player could shoot while reloading
	v1.6 - Improved damage calculation system for exploding bolt
	     - Added CVAR for crossbow one-round-only keeping
	     - Improved damage detection system for normal bolt
	     - Fixed bug with crossbow drop after death
	     - Some minor optimizations/changes
	v1.7 - Added knockback CVAR
	     - Improved knockback from explosion
	     - Fixed bug with score info
	     - Optimized code a bit
	     
	Any suggestions/improvements are welcome!!!
	
	If you find any bug - report it on Crossbow thread, which can be found here
		    http://forums.alliedmods.net/showthread.php?t=101379
	    
	--- Good Luck & Have Fun ;) ---
*/	

#include <amxmodx>
#include <cstrike>
#include <engine>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <zombieplague>

// Uncomment following if you want to see alternative model
//#define ALTERNATIVE_MODEL

// Plugin info
new const PLUGIN[] = "[ZP] Extra Item: Crossbow"
new const VERSION[] = "1.7"
new const AUTHOR[] = "NiHiLaNTh"

// Crossbow/Bolt models
#if defined ALTERNATIVE_MODEL
new const P_MODEL[] = "models/p_crossbow_alt.mdl"
new const V_MODEL[] = "models/v_crossbow_alt.mdl"
new const W_MODEL[] = "models/w_crossbow_alt.mdl"
#else
new const P_MODEL[] = "models/p_crossbow.mdl"
new const V_MODEL[] = "models/v_crossbow.mdl"
new const W_MODEL[] = "models/w_crossbow.mdl"
#endif
new const BOLT_MODEL[] = "models/crossbow_bolt.mdl"

// Some sounds
new const XBOW_SHOOT[] = "weapons/xbow_fire1.wav"
new const XBOW_HITWALL[] = "weapons/xbow_hit1.wav"
new const XBOW_HITSTAB[] = "weapons/xbow_hitbod1.wav"
new const XBOW_RELOAD[] = "weapons/xbow_reload1.wav"

// Sprites
new const EXPLO_SPRITE[] = "sprites/zerogxplode.spr"
new const BLOOD_SPRITE[] = "sprites/blood.spr"
new const BLOODSPRAY_SPRITE[] = "sprites/bloodspray.spr"

// Cached sprite indexes
new sExplo, sBlood, sBlood2

// CVAR pointers
new pDamage, pDamage2, pRadius, pOneRound, pKnockback

// Item ID
new g_crossbow

// Player variables
new g_hasXbow[33] // whether player has Crossbow
new Float:g_last_shot_time[33] // Last time Crossbow used
new g_FullClip[33] // whether player has Full Clip
new g_bInReload[33]

// Max players
new g_maxplayers

// Global vars
new g_restarted

// Message ID's
new g_msgCurWeapon, g_msgAmmoX, g_msgScoreInfo

// Weapon animation sequences
enum
{
	crossbow_idle1,
	crossbow_idle2,
	crossbow_fidget1,
	crossbow_fidget2,
	crossbow_fire1,
	crossbow_fire2,
	crossbow_fire3,
	crossbow_reload,
	crossbow_draw1,
	crossbow_draw2,
	crossbow_holster1,
	crossbow_holster2
}

// Item Cost
#define COST 25

// Precache
public plugin_precache()
{
	// Models
	precache_model(P_MODEL)
	precache_model(V_MODEL)
	precache_model(W_MODEL)
	precache_model(BOLT_MODEL)

	// Sounds
	precache_sound(XBOW_SHOOT)
	precache_sound(XBOW_HITWALL)
	precache_sound(XBOW_HITSTAB)
	precache_sound(XBOW_RELOAD)
	precache_sound("weapons/357_cock1.wav")
	
	// Sprites
	sExplo = precache_model(EXPLO_SPRITE)
	sBlood = precache_model(BLOOD_SPRITE)
	sBlood2 = precache_model(BLOODSPRAY_SPRITE)
}

// Init
public plugin_init()
{
	// New plugin
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_cvar("zp_xbow_version", VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	
	// New extra item
	g_crossbow = zp_register_extra_item("Crossbow", COST, ZP_TEAM_HUMAN)

	// Events
	register_event("HLTV", "Event_NewRound", "a", "1=0", "2=0");
	register_event("TextMsg", "Event_GameRestart", "a", "2=#Game_Commencing", "2=#Game_will_restart_in");
	
	// Log Event
	register_logevent("LogEvent_RoundEnd", 2, "1=Round_End")
	
	// Forwards
	register_forward(FM_CmdStart, "fw_CmdStart")
	register_forward(FM_SetModel, "fw_SetModel")
	RegisterHam(Ham_Item_Deploy, "weapon_awp", "fw_CrossbowDeploy", 1)
	register_forward(FM_UpdateClientData, "fw_UpdateClientData_Post", 1)
	register_forward(FM_Touch, "fw_Touch")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Weapon_Reload, "weapon_awp", "fw_WeaponReload", 1)
	
	// Touches
	register_touch("xbow_bolt", "*", "bolt_touch")
	register_touch("xbow_bolt_xplode", "*", "bolt_touch2")
	register_touch("drop_crossbow", "player", "crossbow_touch")
	
	// CVARs
	pDamage = register_cvar("zp_crossbow_damage", "175") // Damage done by expl
	pDamage2 = register_cvar("zp_crossbow_damage2", "300") // Damage done by bolt
	pRadius = register_cvar("zp_crossbow_radius", "175")
	pOneRound = register_cvar("zp_crossbow_one_round", "1")
	pKnockback = register_cvar("zp_crossbow_knockback", "10")
	
	// Store maxplayers in a global variable
	g_maxplayers = get_maxplayers()

	// Messages
	g_msgCurWeapon = get_user_msgid("CurWeapon")
	g_msgAmmoX = get_user_msgid("AmmoX")
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
}

// When client connected, he cant have our weapon
public client_connect(id)
{
	g_hasXbow[id] = false
	g_FullClip[id] = false
	g_bInReload[id] = false
}

// Someone wants to buy our extra item
public zp_extra_item_selected(id, itemid)
{
	if (itemid == g_crossbow)
	{
		// Already have it
		if (g_hasXbow[id])
		{
			// Warn player
			client_print(id, print_center, "Already have Crossbow!")
			return ZP_PLUGIN_HANDLED
		}
		// Otherwise you can buy it
		else
		{
			// Notice
			client_print(id, print_chat, "[ZP] You bought crossbow")
	
			// Drop primary weapons if have
			if (cs_get_user_hasprim(id))
				engclient_cmd(id, "drop")
	
			// Give him awp
			give_item(id, "weapon_awp")
			
			// Get weapon id
			new weapon_id = find_ent_by_owner(-1, "weapon_awp", id)
			
			if (weapon_id)
			{
				// Set clip ammo
				cs_set_weapon_ammo(weapon_id, 10)
			}
			
			// Set bp ammo
			cs_set_user_bpammo(id, CSW_AWP, 50)
			
			//client_print(id, print_chat, "BP AMMO: %d", cs_get_user_bpammo(id, CSW_AWP))
			
			// Change models
			ChangeModels(id)
			
			// Animation(bugfix)
			UTIL_PlayWeaponAnimation(id, crossbow_draw1)
			
			// Reset
			g_hasXbow[id] = true
			g_FullClip[id] = true
			g_bInReload[id] = false
		
			// Update HUD
			UpdateHud(id)
		}
	}
	return PLUGIN_CONTINUE
}

// Target who have our weapon was infected - reset vars
public zp_user_infected_post(id, infector, nemesis)
{
	if (g_hasXbow[id])
	{
		g_hasXbow[id] = false
		g_FullClip[id] = false
		g_bInReload[id] = false
		UpdateHud(id)
		
		UpdateScore(infector, id, 0, 0, 1)
		
		// Bugfix
		touch_fix(id)
	}
}

// New round started
public Event_NewRound()
{
	if (g_restarted)
	{
		// Strip from Crossnow if game have been restarted
		for (new i = 1; i <= get_maxplayers(); i++)
		{
			if (g_hasXbow[i])
			{
				g_hasXbow[i] = false
				g_FullClip[i] = false
				g_bInReload[i] = false
			}
		}
		g_restarted = false
	}
}

// Restart
public Event_GameRestart()
{
	g_restarted = true
}

// Remove any dropped crossbows
public LogEvent_RoundEnd()
{
	if (get_pcvar_num(pOneRound) == 1)
	{
		for (new i = 1; i < g_maxplayers; i++)
		{
			fm_strip_user_gun(i, CSW_AWP)
			g_hasXbow[i] = false
		}
	}
	
	// Find and remove all dropped crossbows
	new ent = find_ent_by_class(-1, "drop_crossbow")
	if (ent)
		remove_entity(ent)
}

// Called when player start a command(shoot, jump etc.)
public fw_CmdStart(id, uc_handle, seed)
{
	// Ignore dead zombies/nemesis/those who haven't our weapons
	if (!is_user_alive(id) || zp_get_user_zombie(id) || zp_get_user_nemesis(id) || !g_hasXbow[id])
		return FMRES_IGNORED

	// Get amo, clip, and weapon	
	new ammo, clip, weapon = get_user_weapon(id, clip, ammo)
	
	// Not AWP
	if (weapon != CSW_AWP)
		return FMRES_IGNORED
		
	// Buttons	
	new buttons = get_uc(uc_handle, UC_Buttons)
	
	new ent = find_ent_by_owner(-1, "weapon_awp", id)
	
	// Attack1 button was pressed
	if (buttons & IN_ATTACK)
	{
		// We have enough ammo
		if (clip>= 1 && !g_bInReload[id])
		{
			// Next shot time has come
			if (get_gametime() - g_last_shot_time[id] > 2.0)
			{
				// Get FOV(Arkshine)
				new fov; fov = pev(id, pev_fov)
				
				// Default FOV
				if (fov == 90)
				{
					FireCrossbow(id, 0)
				}
				// Is zooming?
				else
					FireCrossbow(id, 1)
					
				g_FullClip[id] = false	
				
				// Decrease ammo
				cs_set_weapon_ammo(ent, cs_get_weapon_ammo(get_pdata_cbase(id, 373)) - 1)
					
				// Update HUD
				UpdateHud(id)
				
				// Remember last shot time
				g_last_shot_time[id] = get_gametime()
			}
		}
		// If out of ammo
		else if (clip <= 1 || ammo <= 1)
		{
			// Play empty sound
			emit_sound(id, CHAN_WEAPON, "weapons/357_cock1.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
		}
		
		// Remove attack button from their buttons mask
		buttons &= ~IN_ATTACK
		set_uc(uc_handle, UC_Buttons, buttons)
	}
	
	// Attack2 button was pressed
	if (buttons & IN_ATTACK2)
	{
		// Update HUD(bugfix)
		UpdateHud(id)
	}
	
	return FMRES_HANDLED
}

// Usually called after player dropped weapons
public fw_SetModel(ent, const model[])
{
	// Prevent invalid entity messages
	if (!pev_valid(ent))
		return FMRES_IGNORED
		
	// Not required model
	if(!equali(model, "models/w_awp.mdl")) 
		return FMRES_IGNORED
	
	// Get owner and classname
	new owner = pev(ent, pev_owner)
	new classname[33]; pev(ent, pev_classname, classname, charsmax(classname))
	
	// Entity classname is a weaponbox
	if(equal(classname, "weaponbox"))
	{
		// The weapon owner has a crossbow
		if(g_hasXbow[owner])
		{
			// Strip from crossbow
			g_hasXbow[owner] = false
			
			// Set world model
			engfunc(EngFunc_SetModel, ent, W_MODEL)
			
			// Update HUD
			UpdateHud(owner)
			
			// Touch fix
			set_task(0.1, "touch_fix", owner)
			
			return FMRES_SUPERCEDE
		}
	}
	
	return FMRES_IGNORED
	
}

// Called when player is holding this weapon
public fw_CrossbowDeploy(iEnt)
{
	// Get ID
	new id = get_pdata_cbase(iEnt, 41, 5)
	
	if (g_hasXbow[id])
	{
		// Change models
		ChangeModels(id)
		
		// Play animation
		UTIL_PlayWeaponAnimation(id, crossbow_draw1)
		
		// Update HUD
		UpdateHud(id)
		
		g_bInReload[id] = false
		
		// Start to reload if clip less than 0(bugfix)
		new awpclip = get_pdata_int(iEnt, 51, 5)
		if (awpclip <= 0)
			fw_WeaponReload(iEnt)
	}
}

// Update client data
public fw_UpdateClientData_Post(id, sw, cd_handle)
{
	// Ignore dead zombies/nemesis/those who haven't our weapons
	if (!is_user_alive(id) || zp_get_user_zombie(id) || zp_get_user_nemesis(id) || !g_hasXbow[id])
		return FMRES_IGNORED
	
	// Get ammo, clip and weapon
	new ammo, clip, weapon = get_user_weapon(id, clip, ammo)
	
	// Not AWP
	if (weapon != CSW_AWP)
		return FMRES_IGNORED
	
	// Block default sounds
	//set_cd(cd_handle, CD_ID, 0)
	set_cd(cd_handle, CD_flNextAttack, halflife_time() + 0,001)
	return FMRES_HANDLED
}

// Called when player touch something
public fw_Touch(ptr, ptd)
{
	// Invalid ent/toucher
	if(!pev_valid(ptr) || !pev_valid(ptd))
		return FMRES_IGNORED;
	
	// Get model, toucherclass, entityclass
	new model[33], toucherclass[33], entityclass[33]
	pev(ptr, pev_model, model, charsmax(model))
	pev(ptr, pev_classname, entityclass, charsmax(entityclass))
	pev(ptd, pev_classname, toucherclass, charsmax(toucherclass))
	
	// TOucher isn't player and entity isn't weapon
	if (!equali(toucherclass, "player") || !equali(entityclass, "weaponbox"))
		return FMRES_IGNORED
	
	// Our world model
	if(equali(model, W_MODEL))
	{
		// If allowed to touch
		if(allowed_toucher(ptd))
		{
			// Pick up weapon
			g_hasXbow[ptd] = true
		}
	}
			
	return FMRES_IGNORED;
}

// Called when player died
public fw_PlayerKilled(victim, attacker, shouldgib)
{
	if (g_hasXbow[victim])
	{
		g_hasXbow[victim] = false
		
		// Drop crossbow
		crossbow_drop(victim)
	}
}

// Called on reload
public fw_WeaponReload(iEnt)
{
	// Get ID 
	new id = get_pdata_cbase(iEnt, 41, 5)

	// Has crossbow 
	if (g_hasXbow[id] && !g_FullClip[id])
	{
		set_pdata_int(iEnt, 54, 1, 4)
		
		// Set animation
		UTIL_PlayWeaponAnimation(id, crossbow_reload)
		
		// Emit sound
		emit_sound(id, CHAN_WEAPON, XBOW_RELOAD, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	
		// Update HUD
		UpdateHud(id)
		
		g_FullClip[id] = true
		g_bInReload[id] = true
		
		// Remove reload task
		set_task(4.0, "no_reload", id)
	}
}	

// Fire crossbow
public FireCrossbow(id, type)
{
	// Play animation
	UTIL_PlayWeaponAnimation(id, crossbow_fire1)
	
	// Get origin, angle, and velocity
	new Float:fOrigin[3], Float:fAngle[3], Float:fVelocity[3]
	pev(id, pev_origin, fOrigin)
	pev(id, pev_v_angle, fAngle)
	
	// New ent
	new ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"));
	
	// Not ent
	if (!ent) return PLUGIN_HANDLED
	
	// If player shot while zooming...
	if (type == 1)
	{
		// Set classnames
		entity_set_string(ent, EV_SZ_classname, "xbow_bolt")
	}
	else
	{
		entity_set_string(ent, EV_SZ_classname, "xbow_bolt_xplode")
	}
	
	// Set bolt model
	entity_set_model(ent, BOLT_MODEL)
	
	// Size
	new Float:mins[3] = {-1.0, -1.0, -1.0}
	new Float:maxs[3] = {1.0, 1.0, 1.0}
	entity_set_size(ent, mins, maxs)
	
	// Movetype
	entity_set_int(ent, EV_INT_movetype, MOVETYPE_FLY)
	
	// Interaction
	entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER)
	
	// Owner
	entity_set_edict(ent, EV_ENT_owner, id)
	
	new Float:origin[3];
	
	// Velocity
	velocity_by_aim(id, 64, fVelocity);
	pev(id, pev_origin, origin);
	
	fOrigin[0] += fVelocity[0];
	fOrigin[1] += fVelocity[1];
	
	// Set origin
	engfunc(EngFunc_SetOrigin, ent, fOrigin)
	
	// Set bolt velocity
	new Float:velocity[3]
	velocity_by_aim(id, 2000, velocity);
	set_pev(ent, pev_velocity, velocity);
	//set_pev(ent, pev_speed, 300.0)
	
	// Correct bolt flight
	vector_to_angle(velocity, fAngle);
	
	// Set angle
	set_pev(ent, pev_angles, fAngle);
	
	// Play sound
	emit_sound(id, CHAN_WEAPON, XBOW_SHOOT, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	
	return PLUGIN_CONTINUE
}

// Normal bolt touched something
public bolt_touch(bolt, ent)
{
	// Invalid ent
	if (!pev_valid(bolt))
	{
		//client_print(0, print_chat, "Error! Invalid entity %d", bolt)
		return
	}
	
	// GEt owner and classname	
	new owner = pev(bolt, pev_owner);
	new classname[32]; pev(ent, pev_classname, classname, 31)
	
	// Get it's origin
	new Float:originF[3], aimvec[3], tid, body
	pev(bolt, pev_origin, originF)
	get_user_origin(owner, aimvec, 3)
	get_user_aiming(owner, tid, body)
	
	if (equal(classname, "player"))
	{
		// Alive...
		if (is_user_alive(tid) == 1 && get_user_godmode(tid) == 0)
		{
			// Zombie/Nemesis
			if (zp_get_user_zombie(tid) || zp_get_user_nemesis(tid))
			{	
				// Get origina and distance
				new Float:VictimOrigin[3]
				pev(tid, pev_origin, VictimOrigin)
					
				// We hit them
				emit_sound(tid, CHAN_WEAPON, XBOW_HITSTAB, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
				
				// Do fake damage
				fakedamage(tid, "crossbow", 0.0, DMG_PARALYZE)
					
				// Health/Damage
				new health = get_user_health(tid)
				new damage = get_pcvar_num(pDamage2)
						
				if (health - damage >= 1)
				{
					set_user_health(tid, health  - damage)
						
					// Create blood
					ShowSomeBlood(VictimOrigin)
					
					//client_print(owner, print_chat, "===>DAMADE %d<===", damage)
				}
				else
				{
					// Kill them
					//user_silentkill(tid)
						
					// Log this
					log_kill(owner, tid, "crossbow", 0)
					
					// Set new Ammo Packs
					zp_set_user_ammo_packs(owner, zp_get_user_ammo_packs(owner) + 1)
				}
				
			}
			// Destroy ent
			set_pev(bolt, pev_flags, FL_KILLME)
		}
	}
	// Not a player(wall etc.)
	if (!equal(classname, "player"))
	{
		// Play sound
		emit_sound(bolt, CHAN_WEAPON, XBOW_HITWALL, VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
		
		// Destroy ent
		set_pev(bolt, pev_flags, FL_KILLME)
	}
}
	
// Exploding bolt touched something
public bolt_touch2(bolt2, ent)
{
	// Invalid ent
	if (!pev_valid(bolt2))
		return
	
	// GEt owner and classname
	new owner = pev(bolt2, pev_owner);
	new classname[32]; pev(ent, pev_classname, classname, 31)
	
	// Get it's origin
	new Float:originV[3]
	pev(bolt2, pev_origin, originV)
	
	// Draw explosion
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_EXPLOSION)
	engfunc(EngFunc_WriteCoord, originV[0])
	engfunc(EngFunc_WriteCoord, originV[1])
	engfunc(EngFunc_WriteCoord, originV[2])
	write_short(sExplo)
	write_byte(15)
	write_byte(15)
	write_byte(0)
	message_end()
	
	// Loop through all players
	for(new i = 1; i < g_maxplayers; i++)
	{
		// Alive...
		if (is_user_alive(i) == 1 && get_user_godmode(i) == 0)
		{
			// Zombie/Nemesis
			if (zp_get_user_zombie(i) || zp_get_user_nemesis(i))
			{
				// Get origina and distance
				new Float:VictimOrigin[3], Float:distance_f, distance
				pev(i, pev_origin, VictimOrigin)
				distance_f = get_distance_f(originV, VictimOrigin)
				distance = floatround(distance_f)
				
				if (distance <= get_pcvar_float(pRadius))
				{
					// Fake damage
					fakedamage(i, "crossbow", 0.0, DMG_BLAST)
					
					// Get health/dmg/damage ratio
					new Float:dratio, damage
					dratio = floatdiv(float(distance),float(get_pcvar_num(pRadius)))
					damage = get_pcvar_num(pDamage) - floatround(floatmul(float(get_pcvar_num(pDamage)), dratio))
					new health = get_user_health(i)
					
					// Make some knockback
					new Float:knockback = get_pcvar_float(pKnockback)
					make_knockback(i, originV, knockback*damage)	
					
					if (health - damage >= 1)
					{
						set_user_health(i, health - damage)
						
						// Create blood
						ShowSomeBlood(VictimOrigin)
						
						//client_print(owner, print_chat, "===>DAMADE %d<===", damage)
					}
					else
					{
						// Silently kill
						//user_silentkill(i)
						
						// Log this
						log_kill(owner, i, "crossbow", 0)
						
						// Set ammo packs
						zp_set_user_ammo_packs(owner, zp_get_user_ammo_packs(owner) + 1)
					}
				}
			}
			set_pev(bolt2, pev_flags, FL_KILLME)
		}
	}
}	

// Crossbow dropped
public crossbow_drop(id)
{
	// Get aimvec and origin
	static Float:flAim[3], Float:flOrigin[3]
	VelocityByAim(id, 64, flAim)
	entity_get_vector(id, EV_VEC_origin, flOrigin)
	
	// Change them a bit
	flOrigin[0] += flAim[0]
	flOrigin[1] += flAim[1]
	
	// New ent
	new iEnt = create_entity("info_target")
	
	// Classname
	entity_set_string(iEnt, EV_SZ_classname, "drop_crossbow")
	
	// Origin
	entity_set_origin(iEnt, flOrigin)
	
	// Model
	entity_set_model(iEnt, W_MODEL)
	
	// Size
	new Float:mins[3] = {-1.0, -1.0, -1.0}
	new Float:maxs[3] = {1.0, 1.0, 1.0}
	entity_set_vector(iEnt, EV_VEC_mins, mins)
	entity_set_vector(iEnt, EV_VEC_maxs, maxs)
	
	// Interaction
	entity_set_int(iEnt, EV_INT_solid, SOLID_TRIGGER)
	
	// Movetype
	entity_set_int(iEnt, EV_INT_movetype, MOVETYPE_TOSS)
	
	// Vars
	g_hasXbow[id] = false
	g_FullClip[id]  = false
	g_bInReload[id] = false	
}

// Touch
public crossbow_touch(xbow, id)
{
	// Prevent invalid ent messages
	if (!is_valid_ent(xbow) || !is_valid_ent(id))
		return PLUGIN_CONTINUE
		
	// Not allowed to touch	
	if (zp_get_user_zombie(id) || zp_get_user_nemesis(id) || g_hasXbow[id])
		return PLUGIN_CONTINUE
		
	// Reset vars
	g_hasXbow[id]  = true
	g_bInReload[id] = false
	
	// Give awp
	give_item(id, "weapon_awp")
	
	// Change models
	ChangeModels(id)
	
	// Set ammo
	cs_set_user_bpammo(id, CSW_AWP, 20)
	
	// Remove crossbow on ground
	remove_entity(xbow)
	
	return PLUGIN_CONTINUE
}
		
// Touch fix
public touch_fix(id)
{
	if (g_hasXbow[id])
		g_hasXbow[id] = false
		
	UpdateHud(id)	
}

// Change models
stock ChangeModels(id)
{
	set_pev(id, pev_viewmodel2, V_MODEL);
	set_pev(id, pev_weaponmodel2, P_MODEL);
}

// Play animation(Arkshine)
stock UTIL_PlayWeaponAnimation(const Player, const Sequence)
{
	set_pev(Player, pev_weaponanim, Sequence);
	
	message_begin(MSG_ONE_UNRELIABLE, SVC_WEAPONANIM, .player = Player);
	write_byte(Sequence);
	write_byte(pev(Player, pev_body));
	message_end();
}

// Update HUD(Arkshine)
stock UpdateHud(Player)
{
	// This set clip ammo
	message_begin(MSG_ONE_UNRELIABLE, g_msgCurWeapon, .player = Player);
	write_byte(true);
	write_byte(CSW_AWP);
	write_byte(cs_get_weapon_ammo(get_pdata_cbase(Player, 373)))
	message_end()
	
	// This set BP ammo
	message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoX, .player = Player);
	write_byte(CSW_AWP);
	write_byte(cs_get_user_bpammo(Player, CSW_AWP));
	message_end();	
}

// Log kill
stock log_kill(killer, victim, weapon[],headshot) 
{
	set_msg_block(get_user_msgid("DeathMsg"), BLOCK_SET)
	ExecuteHamB(Ham_Killed, victim, killer, 2)
	set_msg_block(get_user_msgid("DeathMsg"), BLOCK_NOT)
	
	message_begin(MSG_ALL, get_user_msgid("DeathMsg"), {0,0,0}, 0)
	write_byte(killer)
	write_byte(victim)
	write_byte(headshot)
	write_string(weapon)
	message_end()
	
	//if(zp_get_user_zombie(victim) || zp_get_user_nemesis(victim))
	//{
	//	new frags  = get_user_frags(killer)
	//	set_pev(killer, pev_frags, float(pev(killer, pev_frags) + 1))
	//}
	
	new kname[32], vname[32], kauthid[32], vauthid[32], kteam[10], vteam[10]
	
	get_user_name(killer, kname, 31)
	get_user_team(killer, kteam, 9)
	get_user_authid(killer, kauthid, 31)
	
	get_user_name(victim, vname, 31)
	get_user_team(victim, vteam, 9)
	get_user_authid(victim, vauthid, 31)
	
	log_message("^"%s<%d><%s><%s>^" killed ^"%s<%d><%s><%s>^" with ^"%s^"", 
	kname, get_user_userid(killer), kauthid, kteam, 
	vname, get_user_userid(victim), vauthid, vteam, weapon)
	
	UpdateScore(killer, victim, 0,0, 1)
	
	return PLUGIN_CONTINUE
}

// Allowed toucher
stock allowed_toucher(player)
{
	// Already has it
	if (g_hasXbow[player] || zp_get_user_zombie(player) || zp_get_user_nemesis(player))
		return false
	
	return true
}	

// From WeaponMod
stock make_knockback(victim, Float:origin[3], Float:maxspeed)
{
	// Get and set velocity
	new Float:fVelocity[3];
	kickback(victim, origin, maxspeed, fVelocity)
	entity_set_vector(victim, EV_VEC_velocity, fVelocity);

	return (1);
}

// Blood!!!
stock ShowSomeBlood(const Float:origin[3])
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY) 
	write_byte(TE_BLOODSPRITE) // Spr ID
	write_coord(floatround(origin[0]+random_num(-20,20))) // Positions X...
	write_coord(floatround(origin[1]+random_num(-20,20))) // Y
	write_coord(floatround(origin[2]+random_num(-20,20))) // Z
	write_short(sBlood) // 
	write_short(sBlood2)
	write_byte(248) // Color
	write_byte(5) // Amount
	message_end()
}

// Remove reloading
public no_reload(id)
{
	if (g_bInReload[id])
		g_bInReload[id] = false
}

// From fakemeta_util.inc(VEN)
stock bool:fm_strip_user_gun(index, wid = 0, const wname[] = "") 
{
	if (!is_user_alive(index) || !is_user_connected(index))
		return false
	
	new ent_class[32];
	if (!wid && wname[0])
		copy(ent_class, sizeof ent_class - 1, wname);
	else 
	{
		new weapon = wid, clip, ammo;
		if (!weapon && !(weapon = get_user_weapon(index, clip, ammo)))
			return false;
		
		get_weaponname(weapon, ent_class, sizeof ent_class - 1);
	}

	new ent_weap = find_ent_by_owner(-1, ent_class, index);
	if (!ent_weap)
		return false;

	engclient_cmd(index, "drop", ent_class);

	new ent_box = pev(ent_weap, pev_owner);
	if (!ent_box || ent_box == index)
		return false;

	dllfunc(DLLFunc_Think, ent_box);

	return true;
}

// Extra calulation for knockback
stock kickback(ent, Float:fOrigin[3], Float:fSpeed, Float:fVelocity[3])
{
	// Find origin
	new Float:fEntOrigin[3];
	entity_get_vector( ent, EV_VEC_origin, fEntOrigin );

	// Do some calculations
	new Float:fDistance[3];
	fDistance[0] = fEntOrigin[0] - fOrigin[0];
	fDistance[1] = fEntOrigin[1] - fOrigin[1];
	fDistance[2] = fEntOrigin[2] - fOrigin[2];
	new Float:fTime = (vector_distance( fEntOrigin,fOrigin ) / fSpeed);
	fVelocity[0] = fDistance[0] / fTime;
	fVelocity[1] = fDistance[1] / fTime;
	fVelocity[2] = fDistance[2] / fTime;

	return (fVelocity[0] && fVelocity[1] && fVelocity[2]);
}

// Update score (bugfix)
stock UpdateScore(attacker, victim, frags, deaths, scoreboard)
{
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) + frags))
	
	cs_set_user_deaths(victim, cs_get_user_deaths(victim) + deaths)
	
	if (scoreboard)
	{
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(attacker) // id
		write_short(pev(attacker, pev_frags)) // frags
		write_short(cs_get_user_deaths(attacker)) // deaths
		write_short(0) // class?
		write_short(get_user_team(attacker)) // team
		message_end()
		
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(victim) // id
		write_short(pev(victim, pev_frags)) // frags
		write_short(cs_get_user_deaths(victim)) // deaths
		write_short(0) // class?
		write_short(get_user_team(victim)) // team
		message_end()
	}
}


/*stock fm_get_weapon_id(index, const weapon[])
{
	new ent = -1;
 
	while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", weapon)) != 0)
	{
		if(index == pev(ent, pev_owner))
		return ent;
	}
	return 1;
}

stock give_weapon(id, wpnID, ammo, bpammo) 
{
	new weapon[32]
	get_weaponname(wpnID, weapon, 31)
    
	give_item(id, weapon)
	cs_set_weapon_ammo(fm_get_weapon_id(id, weapon), ammo);
	cs_set_user_bpammo(id, wpnID, cs_get_user_bpammo(id, wpnID) + bpammo)
}*/
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1049\\ f0\\ fs16 \n\\ par }
*/
