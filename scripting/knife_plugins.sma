#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <cstrike>

new KNIFE_V_MODEL[64] = "models/v_hammer.mdl"
new KNIFE_P_MODEL[64] = "models/p_hammer.mdl"
const Wep_awp = ((1<<CSW_KNIFE))

public plugin_init()
{
	register_plugin("KNIFE Model", "1.0", "Serbu")
	
	register_event("WeapPickup","checkModel","b","1=19")
	register_event("CurWeapon","checkWeapon","be","1=1")
}

public plugin_precache()
{
	precache_model(KNIFE_V_MODEL)
	precache_model(KNIFE_P_MODEL)
}

public checkModel(id)
{
	new szWeapID = read_data(2)
	
	if ( szWeapID == CSW_KNIFE )
	{
		set_pev(id, pev_viewmodel2, KNIFE_V_MODEL)
		set_pev(id, pev_weaponmodel2, KNIFE_P_MODEL)
		
	}
}

public checkWeapon(id)
{
	new plrClip, plrAmmo
	new plrWeapId

	if (get_user_flags(id) & ADMIN_KICK) {
	
	plrWeapId = get_user_weapon(id, plrClip , plrAmmo)
	
	if (plrWeapId == CSW_KNIFE)
		checkModel(id)
	else 
		return PLUGIN_CONTINUE
	}
}