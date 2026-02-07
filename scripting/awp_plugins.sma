#include <amxmodx>
#include <fakemeta>
#include <fun>
#include <hamsandwich>
#include <cstrike>

new AWP_V_MODEL[64] = "models/v_awp_fire.mdl"
const Wep_awp = ((1<<CSW_AWP))

public plugin_init()
{
	register_plugin("AWP Model", "1.0", "Serbu")
	
	register_event("WeapPickup","checkModel","b","1=19")
	register_event("CurWeapon","checkWeapon","be","1=1")
}

public plugin_precache()
{
	precache_model(AWP_V_MODEL)
}

public checkModel(id)
{
	new szWeapID = read_data(2)
	
	if ( szWeapID == CSW_AWP )
		set_pev(id, pev_viewmodel2, AWP_V_MODEL)

}

public checkWeapon(id)
{
	new plrClip, plrAmmo
	new plrWeapId
	
	plrWeapId = get_user_weapon(id, plrClip , plrAmmo)
	
	if (plrWeapId == CSW_AWP)
		checkModel(id)
	else 
		return PLUGIN_CONTINUE
}