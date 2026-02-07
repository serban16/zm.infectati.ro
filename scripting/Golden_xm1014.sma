/*
[ZP] Extra Item: Golden XM1014
Team: Humans

Description: This plugin adds a new weapon for Human Teams.
Weapon Cost: 20

Features:
- This weapon do more damage
- This weapon has zoom
- Launch Lasers
- This weapon has unlimited bullets


Cvars:


- zp_goldenxm_dmg_multiplier <5> - Damage Multiplier for Golden XM1014
- zp_goldenxm_gold_bullets <1|0> - Golden bullets effect ?
- zp_goldenxm_custom_model <1|0> - Golden XM1014 Custom Model
- zp_goldenxm_unlimited_clip <1|0> - Golden XM1014 Unlimited Clip 

*/



#include <amxmodx>
#include <engine>	// Added by Shidla
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <cstrike>
#include <zombieplague>

#define is_valid_player(%1) (1 <= %1 <= 32)
#define ENG_NULLENT		-1	// Added by Shidla
#define EV_INT_WEAPONKEY	EV_INT_impulse	// Added by Shidla
#define GXM1014_WEAPONKEY	666	// Added by Shidla
new const g_GXM1014Ent[] = "weapon_xm1014"

new xm1014_V_MODEL[64] = "models/zombie_plague/v_golden_xm1014.mdl"
new xm1014_P_MODEL[64] = "models/zombie_plague/p_golden_xm1014.mdl"
new xm1014_W_MODEL[64] = "models/zombie_plague/w_golden_xm1014.mdl"

/* Pcvars */
new cvar_dmgmultiplier, cvar_goldbullets,  cvar_custommodel, cvar_uclip

// Item ID
new g_itemid

new bool:g_Hasxm1014[33]

new g_hasZoom[ 33 ]
new bullets[ 33 ]

// Sprite
new m_spriteTexture
new SayText

const Wep_xm1014 = ((1<<CSW_XM1014))

public plugin_init()
{
	
	/* CVARS */
	cvar_dmgmultiplier = register_cvar("zp_goldenxm_dmg_multiplier", "5")
	cvar_custommodel = register_cvar("zp_goldenxm_custom_model", "1")
	cvar_goldbullets = register_cvar("zp_goldenxm_gold_bullets", "1")
	cvar_uclip = register_cvar("zp_goldenxm_unlimited_clip", "1")
	
	// Register The Plugin
	register_plugin("[ZP] Extra: Golden XM1014", "1.1", "Wisam187 / Shidla")
	register_cvar("Shidla", "[ZP] Golden XM1014 [w_ model added]", FCVAR_SERVER|FCVAR_SPONLY)
	// Register Zombie Plague extra item
	g_itemid = zp_register_extra_item("Golden XM1014", 50, ZP_TEAM_HUMAN)
	// Death Msg
	register_event("DeathMsg", "Death", "a")
	// Weapon Pick Up
	register_event("WeapPickup","checkModel","b","1=19")
	// Current Weapon Event
	register_event("CurWeapon","checkWeapon","be","1=1")
	register_event("CurWeapon", "make_tracer", "be", "1=1", "3>0")
	// Ham TakeDamage
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	register_forward( FM_CmdStart, "fw_CmdStart" )
	RegisterHam(Ham_Spawn, "player", "fwHamPlayerSpawnPost", 1)
	RegisterHam(Ham_Item_AddToPlayer, g_GXM1014Ent, "fw_GXM1014AddToPlayer")	// Added by Shidla
	SayText = get_user_msgid("SayText")
	register_dictionary("zp_xm1014_w_model.txt")
	
	register_forward(FM_SetModel, "fw_SetModel")	// Added by Shidla
	
}

public client_connect(id)
{
	g_Hasxm1014[id] = false
}

public client_disconnect(id)
{
	g_Hasxm1014[id] = false
}

public Death()
{
	g_Hasxm1014[read_data(2)] = false
}

public fwHamPlayerSpawnPost(id)
{
	g_Hasxm1014[id] = false
}

public plugin_precache()
{
	precache_model(xm1014_V_MODEL)
	precache_model(xm1014_P_MODEL)
	precache_model(xm1014_W_MODEL)
	m_spriteTexture = precache_model("sprites/dot.spr")
	precache_sound("weapons/zoom.wav")
}

public zp_user_infected_post(id)
{
	if (zp_get_user_zombie(id))
	{
		g_Hasxm1014[id] = false
	}
}

public checkModel(id)
{
	if ( zp_get_user_zombie(id) )
		return PLUGIN_HANDLED
	
	new szWeapID = read_data(2)
	
	if ( szWeapID == CSW_XM1014 && g_Hasxm1014[id] == true && get_pcvar_num(cvar_custommodel) )
	{
		set_pev(id, pev_viewmodel2, xm1014_V_MODEL)
		set_pev(id, pev_weaponmodel2, xm1014_P_MODEL)
	}
	return PLUGIN_HANDLED
}

public checkWeapon(id)
{
	new plrClip, plrAmmo, plrWeap[32]
	new plrWeapId
	
	plrWeapId = get_user_weapon(id, plrClip , plrAmmo)
	
	if (plrWeapId == CSW_XM1014 && g_Hasxm1014[id])
	{
		checkModel(id)
	}
	else 
	{
		return PLUGIN_CONTINUE
	}
	
	if (plrClip == 0 && get_pcvar_num(cvar_uclip))
	{
		// If the user is out of ammo..
		get_weaponname(plrWeapId, plrWeap, 31)
		// Get the name of their weapon
		give_item(id, plrWeap)
		engclient_cmd(id, plrWeap) 
		engclient_cmd(id, plrWeap)
		engclient_cmd(id, plrWeap)
	}
	return PLUGIN_HANDLED
}



public fw_TakeDamage(victim, inflictor, attacker, Float:damage)
{
    if ( is_valid_player( attacker ) && get_user_weapon(attacker) == CSW_XM1014 && g_Hasxm1014[attacker] )
    {
        SetHamParamFloat(4, damage * get_pcvar_float( cvar_dmgmultiplier ) )
    }
}

public fw_CmdStart( id, uc_handle, seed )
{
	if( !is_user_alive( id ) ) 
		return PLUGIN_HANDLED
	
	if( ( get_uc( uc_handle, UC_Buttons ) & IN_ATTACK2 ) && !( pev( id, pev_oldbuttons ) & IN_ATTACK2 ) )
	{
		new szClip, szAmmo
		new szWeapID = get_user_weapon( id, szClip, szAmmo )
		
		if( szWeapID == CSW_XM1014 && g_Hasxm1014[id] == true && !g_hasZoom[id] == true)
		{
			g_hasZoom[id] = true
			cs_set_user_zoom( id, CS_SET_AUGSG552_ZOOM, 0 )
			emit_sound( id, CHAN_ITEM, "weapons/zoom.wav", 0.20, 2.40, 0, 100 )
		}
		
		else if ( szWeapID == CSW_XM1014 && g_Hasxm1014[id] == true && g_hasZoom[id])
		{
			g_hasZoom[ id ] = false
			cs_set_user_zoom( id, CS_RESET_ZOOM, 0 )
			
		}
		
	}
	return PLUGIN_HANDLED
}


public make_tracer(id)
{
	if (get_pcvar_num(cvar_goldbullets))
	{
		new clip,ammo
		new wpnid = get_user_weapon(id,clip,ammo)
		new pteam[16]
		
		get_user_team(id, pteam, 15)
		
		if ((bullets[id] > clip) && (wpnid == CSW_XM1014) && g_Hasxm1014[id]) 
		{
			new vec1[3], vec2[3]
			get_user_origin(id, vec1, 1) // origin; your camera point.
			get_user_origin(id, vec2, 4) // termina; where your bullet goes (4 is cs-only)
			
			
			//BEAMENTPOINTS
			message_begin( MSG_BROADCAST,SVC_TEMPENTITY)
			write_byte (0)     //TE_BEAMENTPOINTS 0
			write_coord(vec1[0])
			write_coord(vec1[1])
			write_coord(vec1[2])
			write_coord(vec2[0])
			write_coord(vec2[1])
			write_coord(vec2[2])
			write_short( m_spriteTexture )
			write_byte(1) // framestart
			write_byte(5) // framerate
			write_byte(2) // life
			write_byte(10) // width
			write_byte(0) // noise
			write_byte( 255 )     // r, g, b
			write_byte( 215 )       // r, g, b
			write_byte( 0 )       // r, g, b
			write_byte(200) // brightness
			write_byte(150) // speed
			message_end()
		}
	
		bullets[id] = clip
	}
	
}

public zp_extra_item_selected(player, itemid)
{
	if ( itemid == g_itemid )
	{
		if ( user_has_weapon(player, CSW_XM1014) )
		{
			drop_prim(player)
		}
		give_item(player, "weapon_xm1014")
        print_col_chat( player, "^4[ZP] ^1%L ^3[%L]", LANG_PLAYER, "BUY_XM1014", LANG_PLAYER, "GXM-1014")
		g_Hasxm1014[player] = true;
	}
}

// Added by Shidla
public fw_SetModel(entity, model[])
{
	// Entity is not valid
	if(!is_valid_ent(entity))
		return FMRES_IGNORED;
		
	// Entity model is not w_xm1014
	if(!equal(model, "models/w_xm1014.mdl")) 
		return FMRES_IGNORED;
		
	// Get classname
	static szClassName[33]
	entity_get_string(entity, EV_SZ_classname, szClassName, charsmax(szClassName))
		
	// Not a Weapon box
	if(!equal(szClassName, "weaponbox"))
		return FMRES_IGNORED
	
	// Some vars
	static iOwner, iStoredGalilID
	
	// Get owner
	iOwner = entity_get_edict(entity, EV_ENT_owner)
	
	// Get drop weapon index (galil) to use in fw_Galil_AddToPlayer forward
	iStoredGalilID = find_ent_by_owner(ENG_NULLENT, "weapon_xm1014", entity)
	
	// Entity classname is weaponbox, and galil has founded
	if(g_Hasxm1014[iOwner] && is_valid_ent(iStoredGalilID))
	{
		// Setting weapon options
		entity_set_int(iStoredGalilID, EV_INT_WEAPONKEY, GXM1014_WEAPONKEY)

		// Reset user vars
		g_Hasxm1014[iOwner] = false
		
		// Set weaponbox new model
		entity_set_model(entity, xm1014_W_MODEL)
		
		return FMRES_SUPERCEDE
	}

	return FMRES_IGNORED
}

// Added by Shidla
public fw_GXM1014AddToPlayer (GXM1014, id)
{
	// Make sure that this is M79
	if( is_valid_ent(GXM1014) && is_user_connected(id) && entity_get_int(GXM1014, EV_INT_WEAPONKEY) == GXM1014_WEAPONKEY)
	{
		// Update
		g_Hasxm1014[id] = true

		// Reset weapon options
		entity_set_int(GXM1014, EV_INT_WEAPONKEY, 0)

		return HAM_HANDLED
	}

	return HAM_IGNORED
}

stock drop_prim(id) 
{
	new weapons[32], num
	get_user_weapons(id, weapons, num)
	for (new i = 0; i < num; i++) {
		if (Wep_xm1014 & (1<<weapons[i])) 
		{
			static wname[32]
			get_weaponname(weapons[i], wname, sizeof wname - 1)
			engclient_cmd(id, "drop", wname)
		}
	}
}

stock print_col_chat(const id, const input[], any:...) 
{ 
    new count = 1, players[32]; 
    static msg[191]; 
    vformat(msg, 190, input, 3); 
    replace_all(msg, 190, "!g", "^4"); // Green Color 
    replace_all(msg, 190, "!y", "^1"); // Default Color
    replace_all(msg, 190, "!t", "^3"); // Team Color 
    if (id) players[0] = id; else get_players(players, count, "ch"); 
    { 
        for ( new i = 0; i < count; i++ ) 
        { 
            if ( is_user_connected(players[i]) ) 
            { 
                message_begin(MSG_ONE_UNRELIABLE, SayText, _, players[i]); 
                write_byte(players[i]); 
                write_string(msg); 
                message_end(); 
            } 
        } 
    } 
} 
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ fbidis\\ ansi\\ ansicpg1252\\ deff0{\\ fonttbl{\\ f0\\ fnil\\ fcharset0 Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ ltrpar\\ lang1034\\ f0\\ fs16 \n\\ par }
*/
