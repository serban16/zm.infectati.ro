#include <amxmodx>
#include <cstrike>
#include <engine>
#include <fakemeta>
#include <hamsandwich>
#include <zombie_plague_advance>


// Items Costs
const gauss_weapon_cost = 20 	// Gauss Cost
const gauss_ishield_cost = 10 	// Gauss Immunity Shield Cost 

// Sprites
new const sprite_beam_cylinder[] = "sprites/white.spr"		// Beam Cylinder Sprite
new const sprite_big_explosion[] = "sprites/zerogxplode.spr"	// Explosion Sprite


// Variables
new g_iItemID, g_iItemID2, g_msgSayText, g_msgCurWeapon

// Arrays
new g_iHasGaussWeapon[33], g_iHasGaussIShield[33], g_iCurrentWeapon[33]

// Cvars
new cvar_enable, cvar_apforkill, cvar_oneround, cvar_buyindelay, cvar_explobullet,
cvar_particles, cvar_blood, cvar_nemesis_immune, cvar_enable_gis, cvar_pattack_rate

// Sprite's vars
new g_sprWhite, g_sprBigExplosion

// Offsets
const m_pPlayer = 		41
const m_flNextPrimaryAttack = 	46
const m_flNextSecondaryAttack =	47
const m_flTimeWeaponIdle = 	48

// Plug info.
#define PLUG_VERSION "0.6"
#define PLUG_AUTH "meTaLiCroSS"

/*================================================================================
 [Init and Precache]
=================================================================================*/

public plugin_init()
{
	// Register the Plugin
	register_plugin("[ZP] Extra Item: Gauss", PLUG_VERSION, PLUG_AUTH)
	
	// Cvars
	cvar_enable = register_cvar("zp_gauss_enable", "1")
	cvar_enable_gis = register_cvar("zp_gauss_enable_ishield", "1")
	cvar_buyindelay = register_cvar("zp_gauss_buy_before_modestart", "1")
	cvar_apforkill = register_cvar("zp_gauss_ap_for_kill", "2")
	cvar_oneround = register_cvar("zp_gauss_oneround", "1")
	cvar_nemesis_immune = register_cvar("zp_gauss_nemesis_immune", "1")
	cvar_explobullet = register_cvar("zp_gauss_explosive_bullets", "1")
	cvar_blood = register_cvar("zp_gauss_bloodstyle", "3")
	cvar_particles = register_cvar("zp_gauss_particles", "1")
	cvar_pattack_rate = register_cvar("zp_gauss_primattack_rate", "2.0")
	
	new szCvar[30]
	formatex(szCvar, charsmax(szCvar), "v%s by %s", PLUG_VERSION, PLUG_AUTH)
	register_cvar("zp_extra_gauss", szCvar, FCVAR_SERVER|FCVAR_SPONLY)
	
	// Hamsandwich Forwards
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_awp", "fw_AWP_PrimaryAttack_Post", 1)
	
	// Message ID's vars
	g_msgSayText = get_user_msgid("SayText")
	g_msgCurWeapon = get_user_msgid("CurWeapon")
	
	// Events
	register_event("CurWeapon", "event_CurWeapon", "b", "1=1")	
	
	// Messages
	register_message(get_user_msgid("DeathMsg"), "message_DeathMsg")
	
	// Variables
	g_iItemID = zp_register_extra_item( "Gaus(o runda)", gauss_weapon_cost, ZP_TEAM_HUMAN)  
	g_iItemID2 = zp_register_extra_item("Imunitate Gaus(o runda)", gauss_ishield_cost, ZP_TEAM_ZOMBIE)
}

public plugin_precache()
{
	// Hamsandwich Forwards
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	
	// Models
	precache_model("models/zombie_plague/v_gauss_bugfix1.mdl")
	
	// Sounds
	precache_sound("ambience/particle_suck2.wav")
	
	// Sprites
	g_sprWhite = precache_model(sprite_beam_cylinder)
	g_sprBigExplosion = precache_model(sprite_big_explosion)
}

/*================================================================================
 [Main Events/Messages]
=================================================================================*/

public event_CurWeapon(id)
{
	// Not Alive
	if (!is_user_alive(id))
		return PLUGIN_CONTINUE
		
	// Store weapon id for reference
	g_iCurrentWeapon[id] = read_data(2)
	
	// Check
	if(zp_get_user_zombie(id) || zp_get_user_survivor(id))
		return PLUGIN_CONTINUE
		
	// Has gauss and weapon is AWP
	if(!g_iHasGaussWeapon[id] || g_iCurrentWeapon[id] != CSW_AWP) 
		return PLUGIN_CONTINUE
		
	entity_set_string(id, EV_SZ_viewmodel, "models/zombie_plague/v_gauss_bugfix1.mdl")
	
	return PLUGIN_CONTINUE
}

public message_DeathMsg(msg_id, msg_dest, id)
{
	static szTruncatedWeapon[33], iAttacker, iVictim
	
	// Get truncated weapon
	get_msg_arg_string(4, szTruncatedWeapon, charsmax(szTruncatedWeapon))
	
	// Get attacker and victim
	iAttacker = get_msg_arg_int(1)
	iVictim = get_msg_arg_int(2)
	
	// Non-player attacker or self kill
	if(!is_user_connected(iAttacker) || iAttacker == iVictim)
		return PLUGIN_CONTINUE
		
	// Killed by world, usually executing Ham_Killed and attacker has a Gauss
	if(equal(szTruncatedWeapon, "world") && g_iHasGaussWeapon[iAttacker] && g_iCurrentWeapon[iAttacker] == CSW_AWP)
		set_msg_arg_string(4, "gauss_beam")
		
	return PLUGIN_CONTINUE
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

public client_putinserver(id)
{
	g_iHasGaussWeapon[id] = false
	g_iHasGaussIShield[id] = false
}

public client_disconnect(id)
{
	g_iHasGaussWeapon[id] = false
	g_iHasGaussIShield[id] = false
}

public fw_PlayerSpawn_Post(id)
{
	// Remove IShield
	if(g_iHasGaussIShield[id])
		g_iHasGaussIShield[id] = false
		
	// Remove Weapon
	if(get_pcvar_num(cvar_oneround) || !get_pcvar_num(cvar_enable))
	{
		if(g_iHasGaussWeapon[id])
		{
			g_iHasGaussWeapon[id] = false;
			ham_strip_weapon(id, "weapon_awp")
		}
	}
}

public fw_PlayerKilled(victim, attacker, shouldgib)
{
	if(!is_user_connected(attacker) || !is_user_connected(victim) || attacker == victim || !attacker)
		return HAM_IGNORED
		
	// Victim has a gauss
	if(g_iHasGaussWeapon[victim])
	{
		client_print(victim, print_center, "[Gauss] Power OFF")
		g_iHasGaussWeapon[victim] = false
	}
	
	// Attacker has a gauss and weapon is AWP
	if(g_iHasGaussWeapon[attacker] && g_iCurrentWeapon[attacker] == CSW_AWP)
	{
		// Get Victim's Origin, Give AP cvar status and AP cvar amount
		static iOrigin[3]
		get_user_origin(victim, iOrigin)
		
		// Blood
		switch(get_pcvar_num(cvar_blood))
		{
			case 1:FX_BloodSpurt(iOrigin)
			case 2:FX_BloodStream(iOrigin, 5)
			case 3:
			{
				FX_BloodSpurt(iOrigin)
				FX_BloodStream(iOrigin, 5)
			}
		}
		
		// Particles
		if(get_pcvar_num(cvar_particles)) 
			FX_Particles_Large(iOrigin)
		
		// Get reward cvar
		static iReward
		iReward = get_pcvar_num(cvar_apforkill)
		
		// Cvar is more than 0
		if (bool:iReward != false)
			client_print(attacker, print_center, "[Gaus] Ai omorat un Zombie. +BONUS %d Euro", iReward)
		else
			client_print(attacker, print_center, "[Gaus] Ai omorat un Zombie.")
		
		// Updating Ammopacks
		zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + iReward)
			
	}
	
	return HAM_IGNORED
}

public fw_AWP_PrimaryAttack_Post(awp)
{
	static id
	id = get_pdata_cbase(awp, m_pPlayer, 4)
	
	if(is_user_connected(id) && g_iHasGaussWeapon[id])
	{	
		// Get new fire rate
		static Float:flRate
		flRate = get_pcvar_float(cvar_pattack_rate)
		
		// Set new rates
		set_pdata_float(awp, m_flNextPrimaryAttack, flRate, 4)
		set_pdata_float(awp, m_flNextSecondaryAttack, flRate, 4)
		set_pdata_float(awp, m_flTimeWeaponIdle, flRate, 4)
		
		if(get_pcvar_num(cvar_explobullet))
		{
			// Get end aim origin
			new iEndOrigin[3]
			get_user_origin(id, iEndOrigin, 3)
			
			// Explosion
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY, iEndOrigin) 
			write_byte(TE_EXPLOSION)	
			write_coord(iEndOrigin[0]) 
			write_coord(iEndOrigin[1]) 
			write_coord(iEndOrigin[2]) 
			write_short(g_sprBigExplosion)	
			write_byte(60)	// scale in 0.1's	
			write_byte(20)	// framerate			
			write_byte(TE_EXPLFLAG_NONE)	
			message_end() 
			
			// Beam Cylinder
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY, iEndOrigin) 
			write_byte(TE_BEAMCYLINDER)
			write_coord(iEndOrigin[0])
			write_coord(iEndOrigin[1])
			write_coord(iEndOrigin[2])
			write_coord(iEndOrigin[0])
			write_coord(iEndOrigin[1])
			write_coord(iEndOrigin[2]+200)
			write_short(g_sprWhite)
			write_byte(0)
			write_byte(1)
			write_byte(6)
			write_byte(8)
			write_byte(1)
			write_byte(255)
			write_byte(255)
			write_byte(192)
			write_byte(128)
			write_byte(5)
			message_end()
		}
	}
	
	return HAM_IGNORED
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_bits)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_connected(attacker))
		return HAM_IGNORED
		
	// Victim isn't a Zombie, has a Gauss weapon and Weapon isn't AWP
	if(!zp_get_user_zombie(victim) || !g_iHasGaussWeapon[attacker] || g_iCurrentWeapon[attacker] != CSW_AWP)
		return HAM_IGNORED;
		
	// Nemesis Immunity
	if(get_pcvar_num(cvar_nemesis_immune) && zp_get_user_nemesis(victim))
	{
		// Message
		client_print(attacker, print_center, "Nemesis-ul este imun la Gaus.") 
		
		// Get victim's origin
		static iOrigin[3] 
		get_user_origin(victim, iOrigin)
		
		// Particles
		FX_Particles(iOrigin, 7)
			
		// Damage to 0.0
		SetHamParamFloat(4, 0.0)
		
		return HAM_IGNORED
	}
	
	// Gauss Immunity Shield
	if(get_pcvar_num(cvar_enable_gis) && g_iHasGaussIShield[victim])
	{
		// Messages
		client_print(attacker, print_center, "Inamicul tau este imun la Gaus.")
		client_printcolor(victim, "/g[ZP] Imunitatea Gauss /yte-a protejat de /gGaus. ")
			
		// Get victim's origin
		static iOrigin[3] 
		get_user_origin(victim, iOrigin)
		
		// Particles
		FX_Particles(iOrigin, 4)
			
		// Damage to 0.0
		SetHamParamFloat(4, 0.0)
		
		return HAM_IGNORED
	}

	// Make the Kill
	ExecuteHamB(Ham_Killed, victim, attacker, 2)
	
	// Damage to 0.0
	SetHamParamFloat(4, 0.0)
	
	return HAM_IGNORED
}

/*================================================================================
 [Zombie Plague Forwards]
=================================================================================*/

public zp_extra_item_selected(id, item)
{
	// Gauss Weapon
	if (item == g_iItemID)
	{
		if(get_pcvar_num(cvar_enable))
		{
			if (!zp_has_round_started() && get_pcvar_num(cvar_buyindelay))
			{
				client_printcolor(id, "/g[ZP]/y Trebuie mai intai sa astepti sa inceapa runda.")
				zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_weapon_cost)
					
				return;
			}
			
			if(g_iHasGaussWeapon[id] && user_has_weapon(id, CSW_AWP))
			{
				client_printcolor(id, "/g[ZP]/y Deja ai un Gaus.")
				zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_weapon_cost)
				
				return;
			}
			
			// Var's
			g_iHasGaussWeapon[id] = true
			
			// Gauss
			ham_give_weapon(id, "weapon_awp")
			cs_set_user_bpammo(id, CSW_AWP, 30)
			
			// Msgs
			client_printcolor(id, "/g[ZP]/y Acum tu ai arma Gaus. Zombie sunt instant anihilati daca tragi cu /gGaus/y-ul in ei.")
			
			// Updating Models
			static iAwpID 
			iAwpID = find_ent_by_owner(-1, "weapon_awp", id)
			
			ExecuteHamB(Ham_Item_Deploy, iAwpID)
			
			engclient_cmd(id, "weapon_awp")
			emessage_begin(MSG_ONE, g_msgCurWeapon, _, id)
			ewrite_byte(1) // active
			ewrite_byte(CSW_AWP) // weapon
			ewrite_byte(cs_get_weapon_ammo(iAwpID)) // clip
			emessage_end()
		}
		else
		{
			client_printcolor(id, "/g[ZP]/y Gaus-ul este dezactivat. /gContacteaza Admin-ul.")
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_weapon_cost)
		}
	}
	
	// Gauss Immunity Shield
	if(item == g_iItemID2)
	{
		// Check Cvar
		if(get_pcvar_num(cvar_enable_gis))
		{
			// Check Round Start
			if (!zp_has_round_started() && get_pcvar_num(cvar_buyindelay))
			{
				client_printcolor(id, "/g[ZP]/y Mai intai trebuie sa astepti sa inceapa runda")
				zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_ishield_cost)
					
				return;
			}
			
			if(g_iHasGaussIShield[id])
			{
				client_printcolor(id, "/g[ZP]/y Deja ai o /gImunitate Gaus/y.")
				zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_ishield_cost)
				
				return;
			}
			
			// Var's
			g_iHasGaussIShield[id] = true;
			
			// Small Suck Particle FX
			static iOrigin[3]
			get_user_origin(id, iOrigin)
			FX_Particles(iOrigin, 10)
			
			// Msgs
			client_printcolor(id, "/g[ZP]/y Acum esti imun la Gaus.")
		}
		else
		{
			// Msgs
			client_printcolor(id, "/g[ZP]/y Imunitatea Gaus este dezactivata. /gContacteaza Admin-ul.")
			zp_set_user_ammo_packs(id, zp_get_user_ammo_packs(id) + gauss_ishield_cost)
		}
	}
}

public zp_user_infected_post(id)
{
	// Has a Gauss Weapon
	if(g_iHasGaussWeapon[id])
		g_iHasGaussWeapon[id] = false
		
	// Has a Shield
	if(g_iHasGaussIShield[id])
		g_iHasGaussIShield[id] = false
}

public zp_user_humanized_post(id)
{
	// Has a Shield
	if(g_iHasGaussIShield[id])
		g_iHasGaussIShield[id] = false;
		
	// Has a Gauss Weapon
	if(g_iHasGaussWeapon[id])
		g_iHasGaussWeapon[id] = false;
}

/*================================================================================
 [Internal Functions]
=================================================================================*/

FX_BloodStream(iOrigin[3], count)
{
	for(new i = 1; i <= count; i++)
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, iOrigin) 
		write_byte(TE_BLOODSTREAM)
		write_coord(iOrigin[0])
		write_coord(iOrigin[1])
		write_coord(iOrigin[2]+40)
		write_coord(random_num(-30,30)) // x
		write_coord(random_num(-30,30)) // y
		write_coord(random_num(80,300)) // z
		write_byte(70) // color
		write_byte(random_num(100,200)) // speed
		message_end()
	}
}

FX_BloodSpurt(iOrigin[3])
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY) 
	write_byte(TE_LAVASPLASH)
	write_coord(iOrigin[0]) 
	write_coord(iOrigin[1]) 
	write_coord(iOrigin[2]-26) 
	message_end()
}

FX_Particles_Large(iOrigin[3])
{
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_IMPLOSION) 
	write_coord(iOrigin[0]) 
	write_coord(iOrigin[1]) 
	write_coord(iOrigin[2]) 
	write_byte(200) 
	write_byte(40) 
	write_byte(45) 
	message_end()
	
	// Sound by a new entity
	new iEnt = create_entity("info_target")
	
	// Integer vector into a Float Vector
	new Float:flOrigin[3]
	IVecFVec(iOrigin, flOrigin)
	
	// Set player's origin
	entity_set_origin(iEnt, flOrigin)
	
	// Sound
	emit_sound(iEnt, CHAN_WEAPON, "ambience/particle_suck2.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	emit_sound(iEnt, CHAN_VOICE, "ambience/particle_suck2.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	
	// Remove entity
	remove_entity(iEnt)
}

FX_Particles(iOrigin[3], count)
{
	for(new i = 1; i <= count; i++)
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, iOrigin)
		write_byte(TE_IMPLOSION)
		write_coord(iOrigin[0]) 
		write_coord(iOrigin[1]) 
		write_coord(iOrigin[2]) 
		write_byte(random_num(100, 300))
		write_byte(20) 
		write_byte(3) 
		message_end()
	}
}

/*================================================================================
 [Stocks]
=================================================================================*/

stock ham_give_weapon(id, weapon[])
{
	if(!equal(weapon,"weapon_",7)) 
		return 0

	new wEnt = create_entity(weapon)
	
	if(!is_valid_ent(wEnt)) 
		return 0

	entity_set_int(wEnt, EV_INT_spawnflags, SF_NORESPAWN)
	DispatchSpawn(wEnt)

	if(!ExecuteHamB(Ham_AddPlayerItem,id,wEnt))
	{
		if(is_valid_ent(wEnt)) entity_set_int(wEnt, EV_INT_flags, entity_get_int(wEnt, EV_INT_flags) | FL_KILLME)
		return 0
	}

	ExecuteHamB(Ham_Item_AttachToPlayer,wEnt,id)
	return 1
}

stock ham_strip_weapon(id, weapon[])
{
	if(!equal(weapon,"weapon_",7)) 
		return 0
	
	new wId = get_weaponid(weapon)
	
	if(!wId) return 0
	
	new wEnt
	
	while((wEnt = find_ent_by_class(wEnt, weapon)) && entity_get_edict(wEnt, EV_ENT_owner) != id) {}
	
	if(!wEnt) return 0
	
	if(get_user_weapon(id) == wId) 
		ExecuteHamB(Ham_Weapon_RetireWeapon,wEnt);
	
	if(!ExecuteHamB(Ham_RemovePlayerItem,id,wEnt)) 
		return 0
		
	ExecuteHamB(Ham_Item_Kill, wEnt)
	
	entity_set_int(id, EV_INT_weapons, entity_get_int(id, EV_INT_weapons) & ~(1<<wId))

	return 1
}

stock client_printcolor(const id, const input[], any:...)
{
	new iCount = 1, iPlayers[32]
	
	static szMsg[191]
	vformat(szMsg, charsmax(szMsg), input, 3)
	
	replace_all(szMsg, 190, "/g", "^4") // green txt
	replace_all(szMsg, 190, "/y", "^1") // orange txt
	replace_all(szMsg, 190, "/ctr", "^3") // team txt
	replace_all(szMsg, 190, "/w", "^0") // team txt
	
	if(id) iPlayers[0] = id
	else get_players(iPlayers, iCount, "ch")
		
	for (new i = 0; i < iCount; i++)
	{
		if (is_user_connected(iPlayers[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, iPlayers[i])
			write_byte(iPlayers[i])
			write_string(szMsg)
			message_end()
		}
	}
}
